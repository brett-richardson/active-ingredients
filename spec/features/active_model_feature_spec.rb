require 'spec_helper'

class User
  extend  ActiveIngredients
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  active_ingredients do
    mobile_phone PhoneNumber, validate: true, unique: true
    home_phone   PhoneNumber, validate: true
  end
end


describe User do
  subject(:instance) { described_class.new }

  describe 'home_phone attribute' do
    context 'assigned a string' do
      before { subject.home_phone = '+64 178 174 0230' }

      its(:home_phone!) { should be_a PhoneNumber }
    end

    context 'assigned a ValueObject' do
      before { subject.home_phone = PhoneNumber.new '+64 178 174 0230' }

      its(:home_phone!) { should be_a PhoneNumber }
    end
  end
end
