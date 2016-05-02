require_relative '../deliveries_with_two_santas'

RSpec.describe DeliveriesWithTwoSantas do
  subject(:deliveries) { DeliveriesWithTwoSantas.new(input_string) }
  {
    '^v': 3,
    '^>v<': 3,
    '^v^v^v^v^v': 11
  }.each do |input, target|
    context "with #{input}" do
      let(:input_string) { input.to_s }
      
      it "results in #{target} houses visited" do
        expect(deliveries.call).to eq(target)
      end
    end
  end
end