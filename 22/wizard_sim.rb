SPELLS = {
  magic_missile: { cost: 53, damage: 4 },
  drain: { cost: 73, damage: 2, heal: 2 },
  shield: { cost: 113, duration: 6, armour: 7 },
  poison: { cost: 173, duration: 6, damage: 3  },
  recharge: { cost: 229, duration: 5, mana: 101  }
}

$min_used_mana_for_win = 1000000000

class BattleRound
  def initialize(dificulty_hard, spell_name, boss, player={ hp: 50, mana: 500, mana_used: 0, armour: 0 }, active_spells={}, prev = [])
    @dificulty_hard = dificulty_hard
    @spell_now = spell_name
    @boss = boss.dup
    
    @active_spells = {}
    active_spells.each do |key, val|
      @active_spells[key] = val.dup
    end
    @player = player.dup
    @player[:armour] = 0
    @prev = prev
  end

  def call
    if @dificulty_hard
      @player[:hp] -= 1
      return nil if @player[:hp] <= 0
    end
    
    result = apply_active_spells
    result ||= apply_players_round(@spell_now)


    return nil if @player[:mana_used] > $min_used_mana_for_win
    
    @player[:armour] = 0 # <<< This was the bit that was making everything wrong 
    
    result ||= apply_active_spells
    result ||= apply_player_damage_from_boss

    return result if result

    results = SPELLS.map do |key, content|
      BattleRound.new(@dificulty_hard, key, @boss, @player, @active_spells, @prev.dup << SPELLS.keys.index(@spell_now)).call
    end
    valid_results = results.map{ |inner_result| inner_result unless inner_result == :fail }.compact

    result = valid_results.min unless valid_results.empty?

    if result && result < $min_used_mana_for_win
      puts "New min found: #{result}"
      $min_used_mana_for_win = result
    end

    result
  end

  def apply_player_damage_from_boss
    @player[:hp] -= [@boss[:damage] - @player[:armour], 1].max
    :fail if @player[:hp] <= 0
  end

  def apply_players_round(spell_name)
    return :fail if @active_spells.include? spell_name

    spell = SPELLS[spell_name]

    @player[:mana] -= spell[:cost]
    return :fail if @player[:mana] < 0

    @player[:mana_used] += spell[:cost]

    if spell.include? :duration
      @active_spells[spell_name] = spell.dup
    else
      @boss[:hp] -= spell[:damage] if spell.include? :damage
      @player[:hp] += spell[:heal] if spell.include? :heal
    end

    @player[:mana_used] if @boss[:hp] <= 0
  end

  def apply_active_spells
    @active_spells.each { |name, effect|
      apply_effect(effect)
     }
    @active_spells.delete_if{ |name, effect| effect[:duration] == 0 }

    @player[:mana_used] if @boss[:hp] <= 0
  end

  def apply_effect(effect)
    effect[:duration] -= 1
    @boss[:hp] -= effect[:damage] if effect.include? :damage
    @player[:mana] += effect[:mana] if effect.include? :mana
    @player[:armour] = effect[:armour] if effect.include? :armour
  end
end

answers = SPELLS.map do |name, content|
  BattleRound.new(false, name, {hp: 58, damage: 9} ).call
end

final_answer = answers.compact.min
puts "Easy: #{final_answer}"

$min_used_mana_for_win = 1000000000
answers = SPELLS.map do |name, content|
  BattleRound.new(true, name, {hp: 58, damage: 9} ).call
end
puts "A: #{answers}"

final_answer = answers.compact.min
puts "Hard: #{final_answer}"
