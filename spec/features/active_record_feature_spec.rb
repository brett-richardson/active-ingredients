require 'spec_helper'
require 'fixtures/phone'
require 'fixtures/account'
require 'active_record'


describe Account do
  subject(:instance) { described_class.new }

  describe 'assignment' do
    it 'writes the attribute' do
      instance.should_receive(:write_attribute).with :home_phone, '+64 178 174 0230'
      instance.home_phone = '+64 178 174 0230'
    end
  end

  context 'with home_phone ingredient added' do
    before { instance.home_phone = '+64 178 174 0230' }

    describe '#attributes["home_phone"]' do
      subject { instance.read_attribute :home_phone }

      it { should eq '+64 178 174 0230' }
    end
  end
end
