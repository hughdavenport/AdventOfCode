require 'rspec'
require_relative '../look_and_say'

RSpec.describe LookAndSayGenerator do
  it "initializes to default number" do
    generator = LookAndSayGenerator.new
    expect(generator.number).to eq(1)
  end

  it "generates next number of sequence" do
    generator = LookAndSayGenerator.new(111221)
    generator.next
    expect(generator.number).to eq(312211)
  end
end

RSpec.describe '#digits' do
  it "returns digits of number" do
    expect(digits(123456)).to eq([1, 2, 3, 4, 5, 6])
  end
end

RSpec.describe '#grouped_digits' do
  it "returns grouped digits of number" do
    expect(grouped_digits(122333)).to eq([[1], [2, 2], [3, 3, 3]])
    expect(grouped_digits(111223)).to eq([[1, 1, 1], [2, 2], [3]])
  end
end