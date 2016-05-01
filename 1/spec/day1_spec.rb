require_relative '../day1.rb'

RSpec.describe 'Day 1' do
  context 'Examples' do
    {
      '(())': 0, 
      '()()':0,
      '(((': 3, 
      '(()(()(': 3,
      '))(((((': 3,
      '())': -1, 
      '))(': -1,
      ')))':-3,
      ')())())': -3
    }.each do |floor_string, expected_result|
    
      context "with example input '#{floor_string}'" do
        it "results in #{expected_result}" do
          expect(Day1.new(floor_string.to_s).call).to eq(expected_result)
        end
      end
    end
  end
end