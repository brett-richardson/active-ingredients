require 'spec_helper'
require 'fixtures/address'


describe ActiveIngredients::Ingredient do
  describe 'with Address fixture' do
    subject { Address.new address: '1 Queen St', city: 'Auckland', country: 'NZ' }

    describe 'acts like a struct' do
      its(:address) { should eq '1 Queen St' }
      its(:city   ) { should eq 'Auckland'   }
      its(:country) { should eq 'NZ'         }
    end

    describe '#value' do
      specify { expect{ subject.value }.to raise_error }
    end

    describe '#errors' do
      specify { expect{ subject.errors }.to raise_error }
    end
  end
end
