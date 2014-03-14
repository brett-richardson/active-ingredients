Phone = ActiveIngredients::Ingredient.new(:country_code, :number) do

  FORMAT = %r{^(\+\d{1,2})? ?([\d ]*)$}


  def value  ; "#{ country_code } #{ number }"       ; end
  def valid? ; country_code_valid? and number_valid? ; end


  def convert(value)
    value =~ FORMAT
    self.country_code = $1
    self.number       = $2
  end


  #=============================================================================
    protected
  #=============================================================================


  def country_code_valid? ; country_code =~ %r{^\+\d{2}$} ; end
  def number_valid?       ; number.length > 7             ; end

end
