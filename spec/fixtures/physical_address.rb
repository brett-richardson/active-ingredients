PhysicalAddress = ActiveIngredients::Ingredient.new(
  'PhysicalAddress', :line1, :line2, :city, :code, :country
) do

  def valid?
    line1.present? and city.present? and country.present?
  end

end
