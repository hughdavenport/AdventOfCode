require 'rspec'
require_relative '../reindeer_olympics'

RSpec.describe Reindeer do
  let(:reindeer) { Reindeer.new("Reiny", 10, 5, 3) }

  describe "#run_time" do
    it "returns the total time that reindeer was running at given point in time" do
      expect(reindeer.run_time(1)).to eq(1)
      expect(reindeer.run_time(5)).to eq(5)
      expect(reindeer.run_time(6)).to eq(5)
      expect(reindeer.run_time(8)).to eq(5)
      expect(reindeer.run_time(9)).to eq(6)
    end
  end

  describe "#run_distance" do
    it "returns the total distance that reindeer has run at given point in time" do
      expect(reindeer.run_distance(1)).to eq(10)
      expect(reindeer.run_distance(5)).to eq(50)
      expect(reindeer.run_distance(6)).to eq(50)
      expect(reindeer.run_distance(8)).to eq(50)
      expect(reindeer.run_distance(9)).to eq(60)
    end
  end
end

RSpec.describe "#read_input" do
  it "returns list of reindeers parsed from the input" do
    expect(read_input("Prancer can fly 9 km/s for 12 seconds, but then must rest for 97 seconds.\nDancer can fly 37 km/s for 1 seconds, but then must rest for 36 seconds.")).to eq(
      [Reindeer.new("Prancer", 9, 12, 97), Reindeer.new("Dancer", 37, 1, 36)])
  end
end