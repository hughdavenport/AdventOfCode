SPELLS = {
  magic_missile: { cost: 53, damage: 4 },
  drain: { cost: 73, damage: 2, heal: 2 },
  shield: { cost: 113, effect: { duration: 6, armour: 7} },
  poison: { cost: 173, effect: { duration: 6, each: {damage: 3} } },
  recharge: { cost: 229, effect: { duration: 5, each: { mana: 101} } }
}

class Game
  def initialize( boss )
    @boss = boss
  end
  
  def play_round
  end
  
end

player = { hp: 50, mana: 500 }

def play_round(state)
  state.each do |spell| 
    apply_effect(spell)
  end
  
  if
end


if __FILE__ == $0
  input_file_name = ARGV[0]
  ingredients = {}
  File.open(input_file_name) do |file|
    
  end
  cookie_recipe = WizardSim.new()
  
end
