[![Build Status](https://travis-ci.org/brett-richardson/active-ingredients.png?branch=master)](https://travis-ci.org/brett-richardson/active-ingredients)


Active Ingredients
==================
#### Make Active Record and Value Objects love each other.

ActiveModel (:heart:) Value Objects (:heart:) POROs


&nbsp;
- - - - -


### This is your Rails Model... on Active Ingredients!

    class User < ActiveRecord::Base
      active_ingredients do
      	email        EmailAddress, validate: true, unique: true, allow_nil: false
      	username     ShortName
      	nickname     ShortName
        mobile_phone PhoneNumber, allow_nil: false, unique: true
      	home_phone   PhoneNumber
      	home_address Address, allow_nil: false
      	work_address Address
      	website      Url
      	linked_in    Url
      end
      
      ...
    end


Now you can do this:

    user = User.new
    
    user.home_phone = '+49 3456 3456'
    user.home_phone  # => '+49 3456 3456'
    user.home_phone! # => <Phone country_code: '+49' number: '3456 3456'>
    user.valid?      # => Defers validation to the value object
    
    user.home_address = '1 Queen St, Auckland, New Zealand'
    user.home_address!.city # => Auckland


&nbsp;
- - - - -


Installation (with or without Rails)
====================================

In your Gemfile `gem 'active_ingredients'` and run `bundle install`.


&nbsp;
- - - - -



Usage
=====


## Create Your Ingredient (Value Object)

Treat `ActiveIngredients::Ingredient` as you would a `Struct` (It actually inherits directly from Struct).

Build an ingredient (Value Object) like so `app/values/phone_number.rb`:

	
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
      	country_code =~ %r{^\+\d{2}$}
      end
      
      def number_valid?
        number.length > 7
      end
	end

#### Initialize with the normalized value

    home_phone = PhoneNumber.new '+49 345345 345345'
    home_phone # => <PhoneNumber country_code: '+49' number: '345345 345345'>
    
#### Initialize with specific parts (like a Struct)
    
    work_phone = PhoneNumber.new country_code: '+49', number '345345 345345'>
    work_phone # => <PhoneNumber country_code: '+49' number: '345345 345345'>
    

Your ingredient can implement the following methods:

### #value _(essential)_

This method is used for converting the value object into the type and value used for persistance.


### #valid? _(optional)_

By implementing this method, any ActiveRecord adding this ingredient will defer to the Value Object's valid? method when checking the validity of the containing record automatically.

This default behaviour can be prevented by passing a `validate: false` option when adding the ingredient.

### #convert _(optional)_

Given a single value (usually from the database), initialize this object.
If not defined, the value will populate the first attribute given to the Ingredient.new constructor.
If your Ingredient (Struct) has more than 1 attribute you probably need to implement this method.



## Mix it in
### ActiveRecord
   
    class User < ActiveRecord::Base
      active_ingredients do
      	home_phone   PhoneNumber
      	mobile_phone PhoneNumber, unique: true
      end 
    end


Where `home_phone` is the database column name, and `PhoneNumber` is the class of the Ingredient (Value Object).

#### Available options are:

* __validate__  true/false _(defaults to true if value object has a #valid? method)_
* __allow_nil__ true _(defaults to false)_ - Whether to skip validation for nil
* __unique__    true _(defaults to false)_ - Whether to add a unique validation for this value (TODO: Add :scope support)


### ActiveModel, or Plain Old Ruby Object

Just ensure you extend the ActiveIngredients module like so:

    class User
      extend  ActiveIngredients
      include ActiveModel::Validations # optional

      active_ingredients do
        mobile_phone Phone
      end
    end
    
 
    
&nbsp;
- - - - -

TODO:
=====

1. Support for mapping multiple methods to a Value Object (like `composed_of`)


&nbsp;

&nbsp;

- - - - -

## Contributing

If you'd like to become a contributor, the easiest way it to fork this repo, make your changes, run the specs and submit a pull request once they pass.

To run specs, run:

    bundle install
    bundle exec rake
    
If your changes seem reasonable and the specs pass I'll give you commit rights to this repo and add you to the list of people who can push the gem.


## Copyright

Copyright (c) 2014 Brett Richardson. See LICENSE for details.





