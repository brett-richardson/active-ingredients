module ActiveIngredients
  module Injectors
    module ActiveRecordWithMapping
      extend ActiveIngredients::Injectors::ActiveRecord

      CACHE_METHOD = 'active_ingredient_cache'

      #-------------------------------------------------------------------------
        module_function
      #-------------------------------------------------------------------------

      def call(klass, value_map)
        add_cache_getter  klass, value_map
        add_object_getter klass, value_map
        add_object_setter klass, value_map
        add_getters       klass, value_map
        add_setters       klass, value_map
        add_validation    klass, value_map if value_map.validate?
        add_unique_check  klass, value_map if value_map.unique?
      end

      #-------------------------------------------------------------------------
      # (protected)
      #-------------------------------------------------------------------------

      def add_cache_getter(klass, value_map)
        klass.send :define_method, CACHE_METHOD do
          @active_ingredients_cache ||= {}
        end unless klass.method_defined? CACHE_METHOD
      end

      def add_object_getter(klass, value_map)
        klass.send :define_method, value_map.getter_name do
          cache = send CACHE_METHOD
          cache.fetch value_map.name do
            cache[value_map.name] = value_map.klass.new
          end
        end
      end

      def add_object_setter(klass, value_map)
        klass.send :define_method, value_map.setter_name do |value|
          cache = send CACHE_METHOD
          cache[value_map.name] = if value.kind_of? ActiveIngredients::Ingredient
            value
          else
            value_map.klass.new value
          end
        end
      end

      def add_getters(klass, value_map)
        value_map.mapping.each_pair do |source, target|
          klass.send :define_method, source do
            send( value_map.getter_name ).send target
          end
        end
      end

      def add_setters(klass, value_map)
        value_map.mapping.each_pair do |source, target|
          klass.send :define_method, "#{ source }=" do |value|
            send( value_map.getter_name ).send "#{ target }=", value
          end
        end
      end

      def add_validation(klass, value_map)
        klass.send :define_method, value_map.validation_name do
          value_object = send value_map.getter_name

          return if value_map.allow_nil? and value_object.nil?
          return if value_object.valid?

          value_object.errors.each_pair do |field, messages|
            Array( messages ).each do |m|
              errors[ value_map.source_field_for field ] << m
            end
          end
        end

        klass.validate value_map.validation_name
      end
    end
  end
end
