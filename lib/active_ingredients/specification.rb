class ActiveIngredients::Specification
  def initialize(&block)
    @items = []
    instance_eval &block
  end

  def method_missing(method, *args)
    @items << ActiveIngredients::ValueMap.new( method, *args )
  end

  def each(*args, &block)
    @items.each *args, &block
  end
end
