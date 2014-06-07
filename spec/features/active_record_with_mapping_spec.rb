require 'spec_helper'

describe 'ActiveRecord With Mapping Feature' do
  subject(:instance){ Location.new }

  let(:address_object) do
    PhysicalAddress.new(
      line1: '1 Queen St', city: 'Auckland', country: 'New Zealand'
    )
  end

  describe 'getter method' do
    specify{ instance.address!.should be_a PhysicalAddress }
  end

  describe 'the model is assigned an Ingredient object' do
    before{ instance.address = address_object }

    its(:address1){ should eq address_object.line1   }
    its(:address2){ should eq address_object.line2   }
    its(:city    ){ should eq address_object.city    }
    its(:zipcode ){ should eq address_object.code    }
    its(:country ){ should eq address_object.country }

    describe 'subsequent method-specific updates' do
      before do
        instance.address1 = '2 King Rd'
        instance.city     = 'London'
      end

      specify{ instance.address!.line1.should eq '2 King Rd' }
      specify{ instance.address!.city.should  eq 'London'    }
    end
  end
end
