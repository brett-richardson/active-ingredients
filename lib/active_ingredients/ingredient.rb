class ActiveIngredients::Ingredient < Struct
  def value  ; raise NotImplementedError ; end
  def errors ; raise NotImplementedError ; end

  def initialize(value = nil)
    if value.kind_of? Hash
      value.each_pair{ |k,v| send "#{ k }=", v }
    elsif value
      if respond_to? :convert
        convert value
      elsif respond_to? :value=
        self.value = value
      end
    end
  end
end
