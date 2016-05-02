require_relative '../mine'

RSpec.describe Mine do
  let(:leading_zeroes_count) { 5 }
  subject(:mine) { Mine.new(input_string, leading_zeroes_count) }
  {
    'abcdef': 609043,
    'pqrstuv': 1048970
  }.each do |input, target|
    context "with #{input}" do
      let(:input_string) { input.to_s }
      
      it "results in #{target} as the tail" do
        expect(mine.call).to eq(target)
      end
    end
  end
end