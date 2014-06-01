module ActiveIngredients
  def active_ingredients(&block)
    ActiveIngredients::Specification.new(&block).each do |value_map| # A specification is a DSL class where each iterates over defined active_ingredients
      ingredient_injector_for( self, value_map ).call self, value_map # Call the injector with the class and value_map (a meta object describing the mapping between this klass and the value object
    end
  end

  #-----------------------------------------------------------------------------
    private
  #-----------------------------------------------------------------------------

  def ingredient_injector_for(model, value_map)
    if is_active_record? model # Determine which injector we will use to add methods to the current class
      if value_map.mapping
        ActiveIngredients::Injectors::ActiveRecordWithMapping
      else
        ActiveIngredients::Injectors::ActiveRecord
      end
    else
      ActiveIngredients::Injectors::Poro
    end
  end

  def is_active_record?(model)
    return unless defined? ActiveRecord
    model.ancestors.include? ActiveRecord::Base
  end
end


require 'active_record'
require 'active_ingredients/ingredient'
require 'active_ingredients/value_map'
require 'active_ingredients/specification'
require 'active_ingredients/injectors/active_record'
require 'active_ingredients/injectors/active_record_with_mapping'
require 'active_ingredients/injectors/poro'


ActiveRecord::Base.class_eval { extend ActiveIngredients }
