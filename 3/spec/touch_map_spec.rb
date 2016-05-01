require_relative '../touch_map'

RSpec.describe TouchMap do
  subject(:touch_map) { TouchMap.new(input_string) }
  { '>': Set.new([[0,0],[1,0]]),
    '^>v<': Set.new([[0,0],[0,-1],[1,-1],[1,0]]),
    '^v^v^v^v^v': Set.new([[0,0],[0,-1]])
  }.each do |input, target|
    context "with #{input}" do
      let(:input_string) { input.to_s }
      
      it "results in visits to #{target}" do
        expect(touch_map.call).to eq(target)
      end
    end
  end
end