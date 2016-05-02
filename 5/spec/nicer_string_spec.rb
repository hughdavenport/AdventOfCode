require_relative '../nicer_string'

RSpec.describe NicerString do
  subject(:nicer_string) { NicerString.new(input_string) }
  {
    'qjhvhtzxzqqjkmpb': true,
    'xxyxx': true,
    'uurcxstgmygtbstg': false,
    'ieodomkazucvgmuy': false
  }.each do |input, expected|
    context "with #{input}" do
      let(:input_string) { input.to_s }

      it "#{expected ? 'is' : 'is not'} a nice string" do
        if expected
          expect(nicer_string.call).to be_truthy
        else
          expect(nicer_string.call).to be_falsey
        end
      end
    end
  end
end