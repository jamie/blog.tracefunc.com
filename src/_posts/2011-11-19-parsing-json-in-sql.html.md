---
title: Parsing JSON in SQL
tags:  [ruby, rails, sql]
---

**The Problem:** You have a database column with some data serialzed as JSON
in it that you'd like to pull out into its own column to index it.

**The Solution:** Run a data migration to pull the value out. Table has 5
million rows and you don't want to round trip all that data through
ActiveRecord? Just parse the json directly with some SQL:

READMORE

~~~ruby
def json(key, field='params')
  key_json = "\"#{key}\":"

  # key start/end locations, including ""
  k_a = "LOCATE('#{key_json}', #{field})"
  k_z = "LOCATE('\"', #{field}, #{k_a}+1)" # this is terminating "

  # is there a space after colons?
  spad = "IF(LOCATE('\": ', #{field}), 1, 0)"

  # is value a string?
  val_string = "LOCATE(CONCAT('#{key_json}', IF(#{spad},' ',''), '\"'), #{field}, #{k_a})"
  qpad = "IF(#{val_string}, 1, 0)"

  # value start/end locations, excluding "" if present
  v_a = "(#{k_z}+1 + 1 + #{spad} + #{qpad})" # 1 for colon, spad for optional space, qpad for possible quote

  end_if_string = "LOCATE('\"', #{field}, #{v_a})"
  end_if_not_string = "IF(LOCATE(',', #{field}, #{v_a}), LOCATE(',', #{field}, #{v_a}), LOCATE('}', #{field}, #{v_a}))"

  v_z = "IF(#{val_string}, #{end_if_string}, #{end_if_not_string})"

  value_string = "SUBSTRING(#{field} FROM #{v_a} FOR (#{v_z} - #{v_a}))"
  "IF(#{k_a}, #{value_string}, NULL)"
end

up do
  execute "
    UPDATE model_table
    SET status = #{json('status')}
  "
end
~~~

The generated sql looks pretty gnarly but mysql ran through it stupidly fast.
I shudder to think how long it'd take activerecord to load and update each record individually.

