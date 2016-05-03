Character = Struct.new(:hit_points, :damage, :armor)
Item = Struct.new(:name, :cost, :damage, :armor)

def read_input(input_string)
  character = Character.new

  hit_points_line, damage_line, armor_line = input_string.split("\n")

  hit_points_match = hit_points_line.match(/Hit Points: (.*)/)
  character.hit_points = hit_points_match[1].to_i

  damage_match = damage_line.match(/Damage: (.*)/)
  character.damage = damage_match[1].to_i

  armor_match = armor_line.match(/Armor: (.*)/)
  character.armor = armor_match[1].to_i

  character
end

WEAPONS = [
  Item.new('Dagger', 8, 4, 0),
  Item.new('Shortsword', 10, 5, 0),
  Item.new('Warhammer', 25, 6, 0),
  Item.new('Longsword', 40, 7, 0),
  Item.new('Greataxe', 74, 8, 0)
]

ARMORS = [
  Item.new('Leather', 13, 0, 1),
  Item.new('Chainmail', 31, 0, 2),
  Item.new('Splintmail', 53, 0, 3),
  Item.new('Bandedmail', 75, 0, 4),
  Item.new('Platemail', 102, 0, 5)
]

RINGS = [
  Item.new('Damage +1', 25, 1, 0),
  Item.new('Damage +2', 50, 2, 0),
  Item.new('Damage +3', 100, 3, 0),
  Item.new('Defense +1', 20, 0, 1),
  Item.new('Defense +2', 40, 0, 2),
  Item.new('Defense +3', 80, 0, 3)
]

def possible_equipment_combinations
  Enumerator.new do |values|
    WEAPONS.each do |weapon|
      ([nil] + ARMORS).each do |armor|
        ([[nil]] + RINGS.combination(1).to_a + RINGS.combination(2).to_a).each do |rings|
          values << ([weapon] + [armor] + rings).compact
        end
      end
    end
  end
end

def equipment_cost(equipment)
  equipment.inject(0) { |cost, item| cost + item.cost }
end

def equip_player(equipment)
  player = Character.new
  player.hit_points = 100
  player.armor = equipment.inject(0) { |armor, item| armor + item.armor }
  player.damage = equipment.inject(0) { |damage, item| damage + item.damage }
  player
end

def player_wins?(boss, player)
  boss = boss.dup
  player = player.dup

  attacker = player
  defender = boss
  while player.hit_points > 0 && boss.hit_points > 0
    actual_damage = [1, attacker.damage - defender.armor].max
    defender.hit_points -= actual_damage
    attacker, defender = defender, attacker
  end

  player.hit_points > 0
end

if __FILE__ == $0
  input_file_name = ARGV[0]
  boss = read_input(File.read(input_file_name))

  winning_equipments = possible_equipment_combinations.to_a.select { |equipment| player_wins?(boss, equip_player(equipment)) }

  cheapest_equipment = winning_equipments.min { |eq1, eq2| equipment_cost(eq1) <=> equipment_cost(eq2) }

  puts "Cheapest equipment to win a fight: #{cheapest_equipment} at cost: #{equipment_cost(cheapest_equipment)}"

  losing_equipments = possible_equipment_combinations.to_a.reject { |equipment| winning_equipments.include?(equipment) }

  most_expensive_equipment = losing_equipments.max { |eq1, eq2| equipment_cost(eq1) <=> equipment_cost(eq2) }

  puts "Most expensive equipment to lose a fight: #{most_expensive_equipment} at cost: #{equipment_cost(most_expensive_equipment)}"
end