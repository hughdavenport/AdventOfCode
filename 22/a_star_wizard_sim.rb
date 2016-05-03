SPELLS = {
  magic_missile: { cost: 53, damage: 4 },
  drain: { cost: 73, damage: 2, heal: 2 },
  shield: { cost: 113, effect: { name: :shield, duration: 6, armour: 7} },
  poison: { cost: 173, effect: { name: :poison, duration: 6, damage: 3} },
  recharge: { cost: 229, effect: { name: :recharge, duration: 5,  mana: 101} }
}

class State
  attr_accessor :player_hp, :player_armour, :player_mana, :boss_hp, :boss_damage, :effects, :turn, :used_mana, :previous_state, :spell_used, :hard_mode
  def initialize(player_hp:, player_armour:, player_mana:, boss_hp:, boss_damage:, effects:, turn:, used_mana:, previous_state:, spell_used:, hard_mode: true)
    self.player_hp = player_hp
    self.player_armour = player_armour
    self.player_mana = player_mana
    self.boss_hp = boss_hp
    self.boss_damage = boss_damage
    self.effects = effects
    self.turn = turn
    self.used_mana = used_mana
    self.previous_state = previous_state
    self.spell_used = spell_used
    self.hard_mode = hard_mode
  end

  def apply(spell)
    new_player_hp = player_hp
    new_player_armour = 0
    new_player_mana = player_mana
    new_boss_hp = boss_hp
    new_boss_damage = boss_damage
    new_used_mana = used_mana
    new_turn = turn == :boss ? :player : :boss
    if hard_mode && turn == :player
      new_player_hp -= 1
      # We died, just go now
      return State.new(player_hp: new_player_hp, player_armour: new_player_armour, player_mana: new_player_mana, boss_hp: new_boss_hp, boss_damage: new_boss_damage, effects: nil, turn: new_turn, used_mana: new_used_mana, previous_state: self, spell_used: spell, hard_mode: hard_mode) if new_player_hp <= 0
    end

    # Do effects
    new_effects = effects.map do |effect|
      effect = effect.dup
      effect[:duration] -= 1
      new_player_armour = effect[:armour] if effect.include?(:armour)
      new_boss_hp -= effect.fetch(:damage, 0)
      new_player_mana += effect.fetch(:mana, 0)
      effect
    end
    # Remove used effects
    new_effects.delete_if { |effect| effect[:duration] == 0 }

    # Boss died, just go now
    return State.new(player_hp: new_player_hp, player_armour: new_player_armour, player_mana: new_player_mana, boss_hp: new_boss_hp, boss_damage: new_boss_damage, effects: new_effects, turn: new_turn, used_mana: new_used_mana, previous_state: self, spell_used: spell, hard_mode: hard_mode) if new_boss_hp <= 0

    if turn == :boss
      # Apply boss damage
      new_player_hp -= [(boss_damage - new_player_armour), 1].max
    else
      # Apply spell
      spell_details = SPELLS[spell]
      new_boss_hp -= spell_details.fetch(:damage, 0)
      new_player_hp += spell_details.fetch(:heal, 0)
      new_player_mana -= spell_details.fetch(:cost, 0)
      new_used_mana += spell_details.fetch(:cost, 0)
      new_effects << spell_details[:effect] if spell_details.include?(:effect)
    end

    State.new(player_hp: new_player_hp, player_armour: new_player_armour, player_mana: new_player_mana, boss_hp: new_boss_hp, boss_damage: new_boss_damage, effects: new_effects, turn: new_turn, used_mana: new_used_mana, previous_state: self, spell_used: spell, hard_mode: hard_mode)
  end

  def neighbors
    if turn == :player
      SPELLS.map do |spell, details|
        next if effects.any? { |effect| effect[:name] == spell && effect[:duration] > 1 }
        apply(spell)
      end.compact
    else
      [apply(nil)]
    end
  end

  def won?
    boss_hp <= 0
  end

  def lost?
    player_hp <= 0 || player_mana <= 0
  end

  def pnumber   # poison is most economical, use as estimate
    if won?
      return used_mana
    elsif lost?
      return 10000000000000000000000
    end
    used_mana + ([(3.0 * 6 / 173), (2.0 / 73), (4.0 / 53)].inject{|sum, el| sum + el}.to_f / 3) * boss_hp
  end

  def <=>(other)
    other.pnumber <=> pnumber
  end

  def to_s
    "PNUM: #{pnumber} HP: #{player_hp}, MANA: #{player_mana}, ARM: #{player_armour}, BOSSHP: #{boss_hp}, EFFECTS: #{effects.map { |effect| "#{effect[:name]} #{effect[:duration]}" }}, TURN: #{turn}, LAST_SPELL: #{spell_used}, PREV: #{previous_state}"
  end

  def hash
    effects.hash + player_hp + player_mana + boss_hp
  end

  def eql?(other)
    other.player_hp == player_hp && other.player_mana == player_mana && other.boss_hp == boss_hp && other.effects.eql?(effects)
  end
end

boss_hp = ARGV[0].to_i
boss_damage = ARGV[1].to_i
player_hp = ARGV.fetch(2, "50").to_i
player_mana = ARGV.fetch(3, "500").to_i

start_state = State.new(player_hp: player_hp, player_armour: 0, player_mana: player_mana, boss_hp: boss_hp, boss_damage: boss_damage, effects: [], turn: :player, used_mana: 0, previous_state: nil, spell_used: nil, hard_mode: !ARGV.fetch(4, "").empty?)
#final_state = start_state.apply(:recharge).apply(nil).apply(:shield).apply(nil).apply(:drain).apply(nil).apply(:poison).apply(nil).apply(:magic_missile).apply(nil)
#puts final_state
#states = []
#while final_state
#  states << final_state
#  previous_state = final_state.previous_state
#  final_state.previous_state = nil
#  final_state = previous_state
#end
#states.reverse!
#states.each { |state| puts state; puts state.effects }
final_state = nil

require 'pqueue'
q = PQueue.new
q.push(start_state)
require 'set'
seen = Set.new

count = 0
while !final_state && !q.empty?
  state = q.pop
#  puts "Chose state #{state.player_hp} VS #{state.boss_hp}, with pnumber #{state.pnumber}"
  puts "Chose state #{state.pnumber} #{state.hard_mode ? "HARD_MODE" : "NORMAL_MODE"}" if count % 1000 == 0
  count += 1
  final_state = state if state.won?
  seen.add(state)
  break if final_state
  state.neighbors.each do |new_state|
    next if seen.include?(new_state)
#    puts "     New state: #{new_state} #{new_state.pnumber}"
#    puts "WON! #{new_state}" if new_state.won?
#    puts "     LOST #{new_state} #{new_state.inspect}" if new_state.lost?
    next if new_state.lost?
    q.push(new_state)
  end
end
p q
puts "USED: #{final_state.used_mana}"
puts final_state
p final_state
