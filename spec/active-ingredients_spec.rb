require 'spec_helper'
require 'fixtures/phone'


describe ActiveIngredients do

  let(:dummy_class) { Class.new { extend ActiveIngredients } }
  let(:ar_dummy_class) { Class.new(ActiveRecord::Base) { extend ActiveIngredients } }


  describe '.active_ingredients' do
    specify{
      dummy_class.class_eval do
        active_ingredients do
          mobile_phone Phone
        end
      end
    }

    specify{
      ar_dummy_class.class_eval do
        active_ingredients do
          mobile_phone Phone
        end
      end
    }
  end

end
