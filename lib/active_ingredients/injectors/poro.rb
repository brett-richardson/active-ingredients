module ActiveIngredients
  module Injectors
    module Poro

      #=========================================================================
        module_function
      #=========================================================================

      def call(klass, value_map)
        add_object_getter klass, value_map
        add_value_getter  klass, value_map
        add_setter        klass, value_map
      end


      #=========================================================================
      # (protected)
      #=========================================================================


      def add_object_getter(klass, value_map)
        klass.send :define_method, value_map.getter_name do
          attr = instance_variable_get value_map.instance_variable_name
          return nil if attr.nil?
          value_map.klass.new attr
        end
      end


      def add_value_getter(klass, value_map)
        klass.send :define_method, value_map.name do
          send( value_map.getter_name ).value
        end
      end


      def add_setter(klass, value_map)
        klass.send :define_method, value_map.setter_name do |value|
          new_value = if value.kind_of? ActiveIngredients::Ingredient
            value.value
          else
            value
          end

          instance_variable_set value_map.instance_variable_name, new_value
        end
      end

    end
  end
end
