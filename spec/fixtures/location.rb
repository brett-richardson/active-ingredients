class Location < ActiveRecord::Base
  active_ingredients do
    phone_number Phone

    address PhysicalAddress, mapping: {
      address1: :line1,
      address2: :line2,
      city:     :city,
      zipcode:  :code,
      country:  :country
    }
  end
end
