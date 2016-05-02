require_relative '../cookie_recipe'

RSpec.describe CookieRecipe do
  let(:ingredients) {
    { Butterscotch: {capacity: -1, durability: -2, flavor: 6, texture: 3, calories: 8 },
      Cinnamon: {capacity: 2, durability: 3, flavor: -2, texture: -1, calories: 3 }  }
  }
  subject(:cookie_recipe) { CookieRecipe.new(ingredients) }
  
  context 'highest score' do
    it 'scores 62842880 using 44 Butterscotch and 56 Cinnamon' do
      expect(cookie_recipe.highest_score).to eq(62842880)
      expect(cookie_recipe.used_ingredients).to eq( { Butterscotch: 44, Cinnamon: 56 } )
    end
  end
end