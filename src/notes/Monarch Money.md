---
title: Monarch Money
created: '2023-11-04T00:07:05.272Z'
modified: '2023-11-04T00:13:39.175Z'
---

# Monarch Money

I'm a long-time user of [YNAB](https://www.ynab.com/) to manage my accounts across a few banks. I recently (Nov 2023)saw some news about [Monarch Money](https://www.monarchmoney.com/) and kicked the tires.

First, importing existing YNAB history is reasonably straightforward via a pass on the exported CSV file:

```ruby
### Prerequisites
# 1. Create accounts in Monarch exactly match the name in YNAB
# 2. Run this script to split your "Main Budget - Register" into individual
#    files per account, which will also reformat the columns to match Monarch.
# 3. Import each file into Monarch, it should auto match the account.

require "csv"

# YNAB: "Account","Flag","Date","Payee","Category Group/Category","Category Group","Category","Memo","Outflow","Inflow","Cleared"
# Monarch: "Date","Merchant","Category","Account","Original Statement","Notes","Amount","Tags"

# BOM is messing up CSV.read something fierce, so I'm skipping the header
# row and writing it manually.
UNICODE_BOM = [239, 187, 191].map(&:chr).join.force_encoding("UTF-8") # 0xEFBBBF
YNAB_HEADERS = ["Account", "Flag", "Date", "Payee", "Category Group/Category", "Category Group", "Category", "Memo", "Outflow", "Inflow", "Cleared"]
MONARCH_HEADERS = ["Date", "Merchant", "Category", "Account", "Original Statement", "Notes", "Amount", "Tags"]

ynab = CSV.read(
  Dir.glob("Main*Register.csv")[0],
  headers: YNAB_HEADERS,
  skip_lines: UNICODE_BOM,
  liberal_parsing: true
)

output = {}
ynab.each do |row|
  output[row["Account"]] ||= []
  output[row["Account"]] << {
    "Date" => Date.parse(row["Date"]).strftime("%Y-%m-%d"),
    "Merchant" => row["Payee"],
    "Category" => row["Category"],
    "Account" => row["Account"],
    "Original Statement" => "",
    "Notes" => row["Memo"],
    "Amount" => -row["Outflow"].delete("$").to_f + row["Inflow"].delete("$").to_f,
    "Tags" => ""
  }
end

output.keys.each do |account|
  CSV.open("Monarch - #{account}.csv", "wb") do |csv|
    csv << MONARCH_HEADERS
    output[account].each do |row|
      csv << row.values
    end
  end
end
```

After which, you probably want to tweak category definitions from the settings, and then you can search the Transactions list by category name to migrate over. Alternately, clone your YNAB before exporting, and rename categories to match Monarch's default set.

Some issues I came across while checking things out:

- Investments _really_ want to be automatic, you can't create an Investments account and manually run the balance as far as I can tell - I wound up creating it as an Other account.
- No bank linking outside of the US at the moment, and no support for imports other than CSV, so no Quicken or Quickbooks compatibility, which are both common across the 5-6 financial institutions I've used in Canada.

Good things to call out, though:

- Automatic recurring billing detection worked great (it even picked up my weekly shopping trip even though it was highly variable amounts).
- Love the sankey chart for cash flow, wish it had a middle split to go from inflows -> category groups -> category.






