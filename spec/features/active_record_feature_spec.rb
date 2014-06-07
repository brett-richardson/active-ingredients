require 'spec_helper'

describe Account do
  subject(:instance) { described_class.new }
  let(:nz_number){ '+64 178 174 0230' }

  describe 'assignment' do
    it 'writes the attribute' do
      instance.should_receive(:write_attribute).with 'home_phone', nz_number
      instance.home_phone = nz_number
    end
  end

  context 'with home_phone ingredient added' do
    before { instance.home_phone = nz_number }

    describe '#attributes["home_phone"]' do
      subject { instance.read_attribute :home_phone }

      it { should eq nz_number }
    end
  end

  describe 'creating an Account from a hash' do
    subject { described_class.new home_phone: nz_number }
    its(:home_phone) { should eq nz_number }
  end

  describe 'Validations' do
    context 'with an Account with an invalid phone number' do
      subject{ Account.new home_phone: '*34 ### 3434' }

      it{ should_not be_valid }
      specify{ subject.valid? and subject.errors[:home_phone].should match 'invalid' }
    end

    describe 'unique validation' do
      before { Account.create mobile_phone: nz_number }
      let(:duplicate){ Account.new mobile_phone: nz_number }

      specify{ duplicate.should_not be_valid }
      specify{ duplicate.valid? and duplicate.errors[:mobile_phone].should match 'unique' }
    end
  end
end
