require 'spec_helper'
require 'fixtures/account'


describe 'Validations' do
  let(:full_number){ '+64 234 2313' }

  context 'with an Account with an invalid phone number' do
    subject{ Account.new home_phone: '*34 ### 3434' }

    it{ should_not be_valid }
    specify{ subject.valid? and subject.errors[:home_phone].should match 'invalid' }
  end

  describe 'unique validation' do
    before { Account.create mobile_phone: full_number }
    let(:duplicate){ Account.new mobile_phone: full_number }

    specify{ duplicate.should_not be_valid }
    specify{ duplicate.valid? and duplicate.errors[:mobile_phone].should match 'unique' }
  end
end
