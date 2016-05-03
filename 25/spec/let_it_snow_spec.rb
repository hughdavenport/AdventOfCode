require 'rspec'
require_relative '../let_it_snow'

RSpec.describe "#iteration_for_coords" do
  {
    '1': [1, 1],
    '2': [2, 1],
    '3': [1, 2],
    '4': [3, 1],
    '5': [2, 2],
    '6': [1, 3]
  }.each do |expected_value, coords|
    it "returns #{expected_value.to_s} for #{coords}" do
      expect(iteration_for_coords(coords)).to eq(expected_value.to_s.to_i)
    end
  end
end