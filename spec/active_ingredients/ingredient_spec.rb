require 'spec_helper'


describe ActiveIngredients::Ingredient do
  describe 'with struct-like sub class' do
    before do
      Address = ActiveIngredients::Ingredient.new(:address, :city, :country)
    end

    subject do
      Address.new(
        address: '1 Queen St', city: 'Auckland', country: 'New Zealand'
      )
    end

    describe 'acts like a struct' do
      its(:address){ should eq '1 Queen St'  }
      its(:city   ){ should eq 'Auckland'    }
      its(:country){ should eq 'New Zealand' }
    end

    describe '#value' do
      it 'raises an error if subclass does not implement #value' do
        expect{ subject.value }.to raise_error
      end
    end

    pending 'given an ingredient as an argument' do
      let(:argument){ Address.new }

        it 'returns the argument instead of creating a new instance' do
          expect( Address.new argument ).to be argument
        end
      end
  end
end
