
class CookieFatRecipe
  def initialize(available_ingredients)
    @available_ingredients = available_ingredients
    @available_ingredients_array = @available_ingredients.keys
  end
  
  def get_fat(ingredients)
    ingredients.reduce(0) do |current, ingredient|
      current + @available_ingredients[ingredient][:calories]
    end
  end
  
  def highest_score(fat_total = nil)
    current_highest_score = 0
    @available_ingredients_array.repeated_combination(100).each do |ingredients|
      next if fat_total && get_fat(ingredients) != fat_total
      score = score_cookie(ingredients)
      if score > current_highest_score
        current_highest_score = score
        puts "Current highest = #{score}"
      end
    end
    current_highest_score
  end
  
  def score_cookie(ingredients)
    scores = {}
    counts = {}
    ingredients.each do |key|
      counts[key] = 0 unless counts[key]
      counts[key] += 1
    end
     
    counts.each do |ingredient, count|
      
      @available_ingredients[ingredient].each do |property, value|
        scores[property] = 0 unless scores[property]
        scores[property] += count * value
      end
    end

    scores.reduce(1) do |current, prop_value|
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
  cookie_recipe = CookieFatRecipe.new(ingredients)
  puts "Top score: #{cookie_recipe.highest_score}"
  puts "Top score with fat = 500: #{cookie_recipe.highest_score(500)}"
end
