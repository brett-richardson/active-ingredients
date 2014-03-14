module ActiveIngredients
  module Injectors
    module ActiveRecord

      #=========================================================================
        module_function
      #=========================================================================

      def call(klass, value_map)
        add_object_getter klass, value_map
        add_value_getter  klass, value_map
        add_setter        klass, value_map
        add_validation    klass, value_map if value_map.validate?
        add_unique_check  klass, value_map if value_map.unique?
      end


      #=========================================================================
      # (protected)
      #=========================================================================


      def add_validation(klass, value_map)
        klass.send :define_method, value_map.validation_name do
          return if send( value_map.getter_name ).nil? and value_map.allow_nil?
          return if send( value_map.getter_name ).valid?
          errors[value_map.name] << value_map.error_description
        end

        klass.validate value_map.validation_name
      end


      def add_unique_check(klass, value_map)
        klass.validates_uniqueness_of value_map.name
      end


      def add_object_getter(klass, value_map)
        klass.send :define_method, value_map.getter_name do
          attr = read_attribute value_map.name
          return nil if attr.nil?
          value_map.klass.new attr
        end
      end


      def add_value_getter(klass, value_map)
        klass.send :define_method, value_map.name do
          send( value_map.getter_name ).try :value
        end
      end


      def add_setter(klass, value_map)
        klass.send :define_method, value_map.setter_name do |value|
          new_value = if value.kind_of? ActiveIngredients::Ingredient
            value.value
          else
            value
          end

          write_attribute value_map.name, new_value
        end
      end

    end
  end
end
