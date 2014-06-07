module ActiveIngredients
  class Specification
    attr_accessor :items
    delegate :each, to: :items

    def initialize(&block)
      @items = []
      instance_eval &block
    end

    def method_missing(method, *args)
      items << ValueMap.new(method, *args)
    end
  end
end
