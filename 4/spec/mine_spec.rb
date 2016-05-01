require_relative '../mine'

RSpec.describe Mine do
  subject(:mine) { Mine.new(input_string) }
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