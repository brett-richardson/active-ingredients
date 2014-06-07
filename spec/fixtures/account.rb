class Account < ActiveRecord::Base
  active_ingredients do
    mobile_phone PhoneNumber, validate: true, unique: true
    home_phone   PhoneNumber, validate: true, allow_nil: true
  end
end
