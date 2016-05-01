require_relative '../deliveries'

RSpec.describe Deliveries do
  subject(:deliveries) { Deliveries.new(input_string) }
  {
    '>': 2,
    '^>v<': 4,
    '^v^v^v^v^v': 2
  }.each do |input, target|
    context "with #{input}" do
      let(:input_string) { input.to_s }
      
      it "results in #{target} houses visited" do
        expect(deliveries.call).to eq(target)
      end
    end
  end
end