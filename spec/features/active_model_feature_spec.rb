require 'spec_helper'
require 'fixtures/phone'
require 'fixtures/user'


describe User do
  subject(:instance) { described_class.new }

  describe 'home_phone attribute' do
    context 'assigned a string' do
      before { subject.home_phone = '+64 178 174 0230' }

      its(:home_phone!) { should be_a Phone }
    end

    context 'assigned a ValueObject' do
      before { subject.home_phone = Phone.new '+64 178 174 0230' }

      its(:home_phone!) { should be_a Phone }
    end
  end
end
