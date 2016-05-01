require_relative '../nice_string'

RSpec.describe NiceString do
  subject(:nice_string) { NiceString.new(input_string) }
  {
    'ugknbfddgicrmopn': true,
    'aaa': true,
    'jchzalrnumimnmhp': false,
    'haegwjzuvuyypxyu': false,
    'dvszwmarrgswjxmb': false
  }.each do |input, expected|
    context "with #{input}" do
      let(:input_string) { input.to_s }
      
      it "#{expected ? 'is' : 'is not'} a nice string" do
        if expected
          expect(nice_string.call).to be_truthy
        else
          expect(nice_string.call).to be_falsey
        end
      end
    end
  end
end