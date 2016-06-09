title:  Dynamic ActiveRecord Attributes
tags:   [programming, rails]

Chris Abad wrote yesterday about his experience with [dynamic attributes][], and I thought I'd share mine.

I'm doing something similar to collect data POSTed to a form, but my data is slightly more structured than Chris'. I have a few fields that I expect to be populated most of the time, and the possiblity of arbitrary fields being set as well. My models look like this:

    create_table "leads", :force => true do |t|
      t.column "email", :string, :default => "", :null => false
      t.column "firstname", :string
      t.column "lastname", :string
      t.column "ip", :string, :default => "", :null => false
    end
    create_table "lead_infos", :force => true do |t|
      t.column "lead_id", :integer, :default => 0, :null => false
      t.column "name", :string, :default => "", :null => false
      t.column "value", :string, :default => "", :null => false
    end

Lead, of course, has\_many :lead\_infos. Thus, I can assume that most leads will have an email, first and last name, and an IP address. The name fields are optional, but common enough to warrant being in the main table (also makes for easier lookups and duplicate checking). Other things, like address, city, zip, etc. I want to hang on to if provided, so I store them as a LeadInfo.

I'm in the same boat as Chris though, as I want to provide uniform access to the data points in a Lead, as well as its LeadInfos, using the 'name' field as a key. Chris added an after\_find hook that moved all the correct data in, but since I'm such a fan of metaprogramming, I decided that I would use method\_missing like so:

    class Lead < ActiveRecord::Base
      has_many :lead_infos, :dependent => true

      def method_missing(methodname, *args)
        begin
          super
        rescue NameError
          name = methodname.to_s.chomp('=')
          if (methodname.to_s =~ /=$/)
            LeadInfo.create(:name => name, :value => args.first, :lead_id => self.id)
            self
          else
            LeadInfo.find(:first, :conditions => ['name = ?', name]) or raise
            lead_infos.find_by_name(name).value rescue ''
          end
        end
      end

      ...
    end

Walking through this, I first make sure to call super so that ActiveRecord's method\_missing gets run first. If it can't find anything to do, then it is the Lead's turn to try.

We start by stripping a trailing = if it exists to get the correct name to use. If the = existed, it's being used as a setter, so we just create the new LeadInfo record based off the current Lead, and return self so that we can chain calls if we desire.

Otherwise, it's a getter, so I first verify that there is at least one LeadInfo with the supplied name - if not, then something is very wrong and we want to re-raise the NameError. Elsewise we so a search for the given value and return it, or an empty string if it is not set (the empty string catch-all is specific for the things I'm doing with this bit of hackery, so might not be applicable to everybody).

The performance difference between my code and Chris' is that I take 2 DB queries for each access to the LeadInfo data, but only when you ask for it. I'm not caching the result (which would take some strain away) because my use of it is solely one access each time I load the Lead from the DB, so caching wouldn't help me. On the other hand, if I do a grand find of a bunch of leads (and in a few places in my code that's quite a lot) I'm not getting hit with extra db hits that I'm not going to use most of the time.

There's benefits to both what I've done and what Chris has done, so anyone reading these can take their pick :)

[dynamic attributes]: http://blog.integralimpressions.com/articles/2006/09/12/dynamically-adding-attributes-to-your-model


## Comments

Nice write up. I was going to go the MethodMissing route if it weren't for my requirement to have all the attributes insterted into the objects attributes hash. I think you're write about the catch-all being specific to you. Most people would probably want to re-raise the error and deal with that appropriately elsewhere.

- Chris Abad, at 18:45, Sep 13 2006
