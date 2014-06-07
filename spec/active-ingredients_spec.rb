require 'spec_helper'

describe ActiveIngredients do
  let(:dummy_class) do
    Class.new { extend ActiveIngredients }
  end

  let(:ar_dummy_class) do
    Class.new(ActiveRecord::Base) { extend ActiveIngredients }
  end

  describe '.active_ingredients' do
    specify do
      dummy_class.class_eval do
        active_ingredients { mobile_phone PhoneNumber }
      end
    end

    specify do
      ar_dummy_class.class_eval do
        active_ingredients { mobile_phone PhoneNumber }
      end
    end
  end
end
