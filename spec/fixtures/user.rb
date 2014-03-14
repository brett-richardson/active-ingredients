class User
  extend  ActiveIngredients
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  active_ingredients do
    mobile_phone Phone, validate: true, unique: true
    home_phone   Phone, validate: true
  end
end
