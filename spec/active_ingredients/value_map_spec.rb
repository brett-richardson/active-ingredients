require 'spec_helper'


describe ActiveIngredients::ValueMap do
  subject{ described_class.new :phone, Hash, validate: true, unique: true }

  its(:getter_name){ should eq 'phone!' }
  its(:setter_name){ should eq 'phone=' }
end
