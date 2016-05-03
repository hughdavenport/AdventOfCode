require 'rspec'
require_relative '../rpg_simulator'

RSpec.describe '#player_wins?' do
  it "plays the actual battle" do
    boss = Character.new(12, 7, 2)
    player = Character.new(8, 5, 5)

    expect(player_wins?(boss, player)).to be_truthy
  end
end