MAX_COUNT = 100

class CookieRecipe
  def initialize(available_ingredients)
    @available_ingredients = available_ingredients
  end
  
  def highest_score
    new_scores = {}
    initialize_working_properties
    teaspoons = @available_ingredients.size #we started with one of each
    (teaspoons...100).each do |ittr|
      new_scores = {}
      @available_ingredients.each do |ingredient, properties|
        score_input = @used_ingredients.dup
        
        score_input[ingredient] += 1
        new_scores[ingredient] = score_cookie(score_input)
      end
      
      @used_ingredients[new_scores.max{ |a, b| a[1] <=> b[1] }[0]] += 1
    end
    
    new_scores.max{ |a, b| a[1] <=> b[1] }[1]
  end
  
  def used_ingredients
    @used_ingredients
  end
  
  private
  
  def initialize_working_properties
    @used_ingredients = {}
    @available_ingredients.each_key do |ingredient|
      @used_ingredients[ingredient] = 1
    end
  end
  
  def total_ingredients
    @used_ingredients.each_value.reduce(:+)
  end
  
  def score_cookie(measurements)
    scores = {}
    measurements.each do |ingredient, amount|
      @available_ingredients[ingredient].each do |property, value|
       scores[property] = 0 unless scores[property]
       scores[property] += amount * value
     end
    end
    
    scores.reduce(1) do |current, prop_value |
      next current if prop_value[0] == :calories
      if prop_value[1] < 0
        0
      else
        current * prop_value[1]
      end
    end
  end
end


if __FILE__ == $0
  input_file_name = ARGV[0]
  ingredients = {}
  File.open(input_file_name) do |file|
    file.each_line do |line|
      ingredient_match = /(\w*): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)/.match(line)
      ingredients[ingredient_match[1]] = { capacity: ingredient_match[2].to_i, durability: ingredient_match[3].to_i, flavor: ingredient_match[4].to_i, texture: ingredient_match[5].to_i, calories: ingredient_match[6].to_i }
    end
  end
  cookie_recipe = CookieRecipe.new(ingredients)
  puts "Top score: #{cookie_recipe.highest_score}"
  puts "Using: #{cookie_recipe.used_ingredients}"
end
