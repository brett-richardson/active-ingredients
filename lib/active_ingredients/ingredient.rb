class ActiveIngredients::Ingredient < Struct

  def initialize(value)
    if value.kind_of? Hash
      value.each_pair{ |k,v| send "#{ k }=", v }
    else
      convert value
    end
  end


  def value ; raise 'Please implement #value in your ingredient' ; end

end
