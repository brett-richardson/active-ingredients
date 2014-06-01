[![Build Status](https://travis-ci.org/brett-richardson/active-ingredients.png?branch=master)](https://travis-ci.org/brett-richardson/active-ingredients)


Active Ingredients
==================
#### Making Active Record and Value Objects love each other.

ActiveModel (:heart:) Value Objects (:heart:) POROs

### Inspired by: ActiveRecord#composed_of, money-rails & Virtus

* Because your User object shouldn't concern itself with email validity.

  That belongs in an Email object.

* Because your Account object shouldn't concern itself about currency conversion.

  That belongs in a Money object.

* Because your Project model should't concern itself with Url formatting.

  That belongs in a Url object.


&nbsp;
- - - - -


Overview: The quick and dirty
=============================



1.) Create a Value Object (Ingredient), which is just a slightly modified Struct:

```ruby
ArticleCategory = ActiveIngredients::Ingredient.new(:name) do
  def value
    name.strip.downcase
  end

  def valid?
    value.length < 25
  end

  def error_message
    'is too long'
  end
end
```

2.) Map a database columns to this ValueObject (Ingredient):

```ruby
class Article < ActiveRecord::Base
  active_ingredients do
    main_category ArticleCategory
    sub_category  ArticleCategory
  end
end
```

3.) ??? _validation methods added automatically, override with validate: false option_

4.) Profit!



&nbsp;
- - - - -

### This is your Rails Model... on Active Ingredients!

```ruby
class User < ActiveRecord::Base
  active_ingredients do
    email        EmailAddress, unique: true
    mobile_phone PhoneNumber,  unique: true, allow_nil: true
    home_phone   PhoneNumber,  validate: false
    website      Url

    address PhysicalAddress, mapping: {
      address1:  :address1,
      address2:  :address2,
      city:      :city,
      postcode:  :code,
      country:   :country,
      longitude: :lng,
      lattitude: :lat
    }

    name PersonName, mapping: {
      first_name: :first
      last_name:  :last
      full_name:  :full
    }
  end

  ...
end
```


Now you can do this:

```ruby
user = User.new

user.website = 'dablweb.com'
user.website  # => 'http://www.dablweb.com' (normalized value)
user.website! # => <Url protocol: 'http://' domain: 'dablweb.com' ...>
user.valid?   # => Defers validation to the value object (user.website!.valid?)

user.home_address = '1 Queen St, Auckland, New Zealand'
user.home_address!.city # => Auckland
```


&nbsp;
- - - - -


Installation (with or without Rails)
====================================

In your Gemfile `gem 'active_ingredients'` and run `bundle install`.
And you are ready!


&nbsp;
- - - - -



Usage
=====


## Create Your Ingredient (Value Object)

Treat `ActiveIngredients::Ingredient` as you would a `Struct` (It actually inherits directly from Struct).

Build an ingredient (Value Object) like so `app/values/phone_number.rb`:

```ruby
PhoneNumber = ActiveIngredients::Ingredient.new(:country_code, :number) do
  FORMAT = %r{^(\+\d{1,2})? ?([\d ]*)$}

  def value
    "#{ country_code } #{ number }"
  end

  def valid?
    country_code_valid? and number_valid?
  end

  def convert(value)
    value =~ FORMAT
    self.country_code = $1
    self.number       = $2
  end

  protected

  def country_code_valid?
    country_code =~ %r{^\+\d{1,2}$}
  end

  def number_valid?
    number.length > 7
  end
end
```

#### Initialize with the normalized value
```ruby
  home_phone = PhoneNumber.new '+49 345345 345345'
  home_phone # => <PhoneNumber country_code: '+49' number: '345345 345345'>
```

#### Initialize with specific parts (like a Struct)
```ruby
  work_phone = PhoneNumber.new country_code: '+49', number: '345345 345345'
  work_phone # => <PhoneNumber country_code: '+49' number: '345345 345345'>
```


Your ingredient can implement the following methods:

### #value _(essential unless using the mapping option)_

This method is used for converting the value object into the type and value used for persistance.


### #valid? _(optional)_

By implementing this method, any ActiveRecord adding this ingredient will defer to the Value Object's valid? method when checking the validity of the containing record automatically.

This default behaviour can be prevented by passing a `validate: false` option when adding the ingredient.


### #convert _(essential for Value Objects with more than 1 inner attribute)_

Given a single value (usually from the database), initialize this object.
If not defined, the value will populate the first attribute given to the Ingredient.new constructor.
If your Ingredient (Struct) has more than 1 attribute you probably need to implement this method.



## Mix it in
### ActiveRecord

```ruby
class User < ActiveRecord::Base
  active_ingredients do
    home_phone   PhoneNumber
    mobile_phone PhoneNumber, unique: true
  end
end
```


Where `home_phone` is the database column name, and `PhoneNumber` is the class of the Ingredient (Value Object).

#### Available options are:

* **validate** true/false *(defaults to true if value object has a #valid? method)*
* **allow\_nil** true *(defaults to false)* - Whether to skip validation for nil
* **error** String *(defaults to "<column_name> is invalid")* - Custom error message
* **unique** true *(defaults to false)* - Whether to add a unique validation for this value (TODO: Add :scope support)


### ActiveModel, or Plain Old Ruby Object

Just ensure you extend the ActiveIngredients module like so:
Also, note: Non-active record objects will map attributes to instance variables.
(when used with ActiveRecord, they go into the @attributes hash)

```ruby
class User
  extend  ActiveIngredients
  include ActiveModel::Validations # optional

  active_ingredients do
    mobile_phone Phone
  end
end
```


&nbsp;
- - - - -

TODO:
=====

1. Support for mapping multiple methods to a Value Object (like `composed_of`)
2. Add defaults


&nbsp;

&nbsp;

- - - - -

## Contributing

If you'd like to become a contributor, the easiest way it to fork this repo, make your changes, run the specs and submit a pull request once they pass.

To run specs, run `bundle install && bundle exec rspec`

If your changes seem reasonable and the specs pass I'll give you commit rights to this repo and add you to the list of people who can push the gem.


## Copyright

Copyright (c) 2014 Brett Richardson. See LICENSE for details.
