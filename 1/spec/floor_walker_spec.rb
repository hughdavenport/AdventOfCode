require_relative '../floor_walker'

RSpec.describe FloorWalker do
  context 'Final floor examples' do
    {
      '(())': 0,
      '()()':0,
      '(((': 3,
      '(()(()(': 3,
      '))(((((': 3,
      '())': -1,
      '))(': -1,
      ')))': -3,
      ')())())': -3
    }.each do |floor_string, expected_result|
      context "with example input '#{floor_string}'" do
        it "final floor is #{expected_result}" do
          expect(FloorWalker.new(floor_string.to_s).call.final_floor).to eq(expected_result)
        end
      end
    end
  end

  context 'Entering basement examples' do
    {
      '(())': nil,
      '()()': nil,
      '((': nil,
      '(()))((': 5,
      ')(': 1,
      '())((())))': 3
    }.each do |floor_string, expected_result|
      context "with example input '#{floor_string}'" do
        it "position on entering basement is #{expected_result}" do
          expect(FloorWalker.new(floor_string.to_s).call.position_on_entering_basement).to eq(expected_result)
        end
      end
    end
  end
end