require 'spec_helper'


describe ActiveIngredients::Specification do

  subject(:instance) { described_class.new do ; end }

  it 'raises an error when created without a &block' do
    expect { described_class.new }.to raise_error
  end

  describe '#initialize' do
    it 'initializes an @items array' do
      instance.instance_variable_get(:@items).should be_an Array
    end

    it 'calls the supplied block' do
      block = ->(_){ @items << 'test_abc' }
      instance = described_class.new &block
      instance.instance_variable_get(:@items).should include 'test_abc'
    end
  end

end
