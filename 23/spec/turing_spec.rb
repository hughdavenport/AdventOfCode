require_relative '../turing'

RSpec.describe Turing do
  it "executes commands as in example" do
    commands = ["inc a", "jio a, +2", "tpl a", "inc a"]
    turing = Turing.new(commands)
    turing.execute
    expect(turing.register('a')).to eq(2)
  end
end