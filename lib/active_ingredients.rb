module ActiveIngredients

  def active_ingredients(&block)
    injector = if ancestors.include? ActiveRecord::Base # Determine which injector we will use to add methods to the current class
      ActiveIngredients::Injectors::ActiveRecord
    else
      ActiveIngredients::Injectors::Poro
    end

    ActiveIngredients::Specification.new(&block).each do |value_map| # A specification is a DSL class where each iterates over defined active_ingredients
      injector.call self, value_map # Call the injector with the class and value_map (a meta object describing the mapping between this klass and the value object
    end
  end

end


require 'active_record'
require 'active_ingredients/ingredient'
require 'active_ingredients/value_map'
require 'active_ingredients/specification'
require 'active_ingredients/injectors/active_record'
require 'active_ingredients/injectors/poro'


ActiveRecord::Base.class_eval { extend ActiveIngredients }
