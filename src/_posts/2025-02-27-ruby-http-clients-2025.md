---
title:  Ruby HTTP Clients in 2025
tags:   [blog, coding]
---

At the dayjob, we do payments, both credit card and bank transfers.
Over the years, I've done over a dozen integrations to support the banks our customers use, using a mix of HTTP and SFTP.

The latest one we had was working with a bank that used an HTTP API to submit transactions, but was extremely picky about how the request was made.
We needed to make an HTTP call with:

- a custom Authorization header format (literally Basic auth but with a different name)
- a custom (nonstandard) header
- a multipart form data field with a required content-type
- a separate multipart file upload

After massaging our request enough to get it working with Net::HTTP, I thought I'd give some other options a shot for comparison.

<!-- EXCERPT -->

There was [a blog post by honeyryderchuck](https://honeyryderchuck.gitlab.io/2023/10/15/state-of-ruby-http-clients-use-httpx.html)
a bit over a year ago that did a big shootout, and I'm running through the subset of those that I've actually used:
Net::HTTP, [Faraday](), [HTTP](), and [HTTPX]().
(I've also used [HTTParty]() in past years, but it's not what I'd recommend for this much request complexity.)

[Faraday]: https://github.com/lostisland/faraday
[HTTP]: https://github.com/httprb/http
[HTTPX]: https://honeyryderchuck.gitlab.io/httpx/rdoc/
[HTTParty]: https://github.com/jnunemaker/httparty

First, some boilerplate - sample data, and a common class stub and usage example:

```ruby
class HttpClient
  def initialize(auth)
    @host = 'example.com'
    @path = '/api/path'
    @auth = auth
  end

  def passcode
    Base64.encode64("#{@auth[:user]}:#{@auth[:pass]}").chomp
  end

  def post(criteria, transactions_csv)
    # ...
  end
end

auth = {user: 'user', pass: 'pass'}
client = HttpClient.new(auth)

criteria = { process_date: "#{Date.today.strftime('%Y%m%d')}" }
transactions_csv = <<~CSV.gsub("\n", "\r\n")
  E,C,001,99001,09400313371,10000,TABC00001001,ACME Corp
  E,C,002,99002,09400313372,20000,TABC00001002,John Doe
  E,C,003,99003,09400313373,30000,TABC00001003,Jane Doe
CSV
client.post(criteria, transactions_csv).body
```

This sets up a class to hold the URL and authentication, and a generic helper for the Authorization header.
Then we set up our form data blob (to be rendered to JSON) and file data - note that Net\::HTTP expects an actual File
object for the file upload (and Faraday wrapping Net\::HTTP needs the same), but in this example we'd be generating it live from database records and so we expect to wrap it in a StringIO.

The baseline implementation then, is Net::HTTP.
To get multipart form support, we need the `multipart-post` gem, and `require 'net/http/post/multipart'`.

As part of our API experimentation we also tried `http-form_data`, which is part of the HTTP project, but that needed a bunch of boilerplate to get set up, but `multipart-post` winds up being fairly clean.
It's still Net::HTTP though, which means suffering through its old-school object-oriented API.
The only really exciting thing to call out here is the magic `:parts` header that `multipart-post` supports to let us provide the content-type for the formdata part of the payload.

```ruby
def post_net_http(criteria, transactions_csv)
  form_data = {
    criteria: criteria.to_json,
    transactions: UploadIO.new(
      StringIO.new(transactions_csv),
      'text/plain', 'transactions.csv'
    )
  }

  headers = {
    'Authorization' => "Passcode #{passcode}",
    'filetype'      => 'STD',
    :parts          => {
      criteria: {'Content-Type' => 'application/json'},
    }
  }

  request = Net::HTTP::Post::Multipart.new(@path, form_data, headers)

  http = Net::HTTP.new(@host, 443).tap do |http|
    http.use_ssl = true
  end
  http.request(request)
end
```

As mentioned, Faraday is a wrapper around Net::HTTP and so winds up looking fairly similar.
It needs a separate `faraday-multipart` gem for multipart support, but doesn't need special hand-holding to manage part content-types.
Also, actually setting up the connection object is much more readable.
My biggest gripe is headers being provided as an argument to `new`, and not being supported by `conn.request :headers` or something.

```ruby
def post_faraday(criteria, transactions_csv)
  form_data = {
    criteria: Faraday::Multipart::ParamPart.new(
      criteria.to_json,
      'application/json'
    ),
    transactions: Faraday::Multipart::FilePart.new(
      StringIO.new(transactions_csv),
      'text/plain',
      'transactions.csv'
    )
  }

  headers = {
    'filetype' => 'STD'
  }

  http = Faraday.new("https://#{@host}", headers:) do |conn|
    conn.request :authorization, 'Passcode', passcode
    conn.request :multipart
  end

  http.post(@path, form_data)
end
```

For HTTP The Gem, despite being a separate gem at least the multipart form support is tagged as a dependency so it's available by default.
It's a slight step down from the others in that you need to juggle two different classes while assembling the form data, but otherwise it's nearly identical to Faraday.
On the plus side, it's smart enough to handle a String file part as well as an IO, and the HTTP gem chained API calls are always pleasant to work with.

```ruby
def post_http(criteria, transactions_csv)
  form = HTTP::FormData::Multipart.new({
    criteria: HTTP::FormData::Part.new(
      criteria.to_json,
      content_type: 'application/json'
    ),
    transactions: HTTP::FormData::Part.new(
      transactions_csv,
      content_type: 'text/plain',
      filename: 'transactions.csv'
    )
  })

  http = HTTP
    .auth("Passcode #{passcode}")
    .headers('filetype' => 'STD')

  http.post("https://#{@host}#{@path}", form:)
end
```

Finally, HTTPX: no separate gem for multipart, it's supported out of the box.
No wrapper classes, just a nested hash.
Same readable chained API as HTTP, though the `with` method feels incongruous.

```ruby
def post_httpx(criteria, transactions_csv)
  form = {
    criteria: {
      content_type: 'application/json',
      body: criteria.to_json
    },
    transactions: {
      content_type: 'text/plain',
      filename: 'transactions.csv',
      body: transactions_csv
    }
  }

  http = HTTPX
    .plugin(:auth)
    .authorization("Passcode #{passcode}")
    .with(headers: {'filetype' => 'STD'})

  http.post("https://#{@host}#{@path}", form:)
end
```

I think in the end my preference is HTTPX, which on a technical level edges out HTTP mostly on account of being pure ruby and so slightly easier to deploy.
(And to be fair, HTTP's FormData providing just one Part class makes it fairly straightforward to convert an HTTPX-style raw hash into an appropriate Multipart format, if you prefer that API.)
Both are good choices for a batteries-included addition to your Gemfile.

Net\::HTTP and Faraday are both a bit more rigid to work with, though if it wasn't for Net\::HTTP still needing another gem for multipart support, I'd still give it consideration despite its warts due to being already available in the standard library.
Especially for a library (the fewer dependencies your library has, the easier it is on users of that library to manage upgrades due to fewer dependency version conflicts).
