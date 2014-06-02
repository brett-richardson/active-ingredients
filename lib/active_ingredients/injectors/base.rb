module ActiveIngredients
  module Injectors
    class Base
      def initialize(klass, value_map)
        @klass, @value_map = klass, value_map
      end

      private

      attr_reader :klass, :value_map
    end
  end
end
