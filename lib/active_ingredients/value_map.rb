module ActiveIngredients
  ValueMap = Struct.new(:name, :klass, :options) do
    def initialize(*args)
      super *args
      self.options ||= Hash.new
    end

    #= Names ===

    def getter_name            ; "#{ name }!"                        ; end
    def setter_name            ; "#{ name }="                        ; end
    def instance_variable_name ; "@#{ name }".to_sym                 ; end
    def validation_name        ; "active_ingredient_#{ name }_valid" ; end

    #= Conditionals ===

    def unique?    ; options.fetch :unique,    false ; end
    def allow_nil? ; options.fetch :allow_nil, true  ; end

    def validate?
      options[:validate] != false
    end

    #= Queries ===

    def mapping ; options[:mapping] ; end

    def source_field_for(target = nil)
      return name unless target && mapping
      mapping.key(target) || target
    end

    def error_description
      options[:error] || "#{ name } is invalid."
    end
  end
end
