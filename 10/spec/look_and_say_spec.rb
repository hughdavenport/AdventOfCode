require 'rspec'
require_relative '../look_and_say'

RSpec.describe LookAndSayGenerator do
  it "initializes to default string" do
    generator = LookAndSayGenerator.new
    expect(generator.string).to eq('1')
  end

  it "generates next number of sequence" do
    generator = LookAndSayGenerator.new('111221')
    expect(generator.call).to eq('312211')
  end
  
  it "provides the input" do
    generator = LookAndSayGenerator.new('111221')
    expect(generator.string).to eq('111221')
  end
end
