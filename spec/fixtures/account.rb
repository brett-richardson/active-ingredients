class Account < ActiveRecord::Base
  active_ingredients do
    mobile_phone Phone, validate: true, unique: true
    home_phone   Phone, validate: true, allow_nil: true
  end
end
