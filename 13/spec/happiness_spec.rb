require 'rspec'
require_relative '../happiness'

RSpec.describe HappinessTable do
  let(:happiness_table) { HappinessTable.new }

  it "stores happiness factors" do
    happiness_table.add_happiness_condition("Bob", "Alice", 120)
    happiness_table.add_happiness_condition("Alice", "Bob", -50)

    expect(happiness_table.persons).to match_array(["Alice", "Bob"])
  end

  it "calculates happiness factor for table arrangement" do
    happiness_table.add_happiness_condition("Alice", "Bob", -50)
    happiness_table.add_happiness_condition("Alice", "Charlie", 60)
    happiness_table.add_happiness_condition("Bob", "Charlie", 100)
    happiness_table.add_happiness_condition("Bob", "Alice", -100)
    happiness_table.add_happiness_condition("Charlie", "Alice", -220)
    happiness_table.add_happiness_condition("Charlie", "Bob", 200)

    expect(happiness_table.happiness_factor(["Alice", "Bob", "Charlie"])).to eq(-10)
  end
end

RSpec.describe "#read_input" do
  let(:happiness_table) { instance_double(HappinessTable) }

  it "reads happiness factors from text" do
    expect(happiness_table).to receive(:add_happiness_condition).with("David", "George", 75).ordered
    expect(happiness_table).to receive(:add_happiness_condition).with("David", "Mallory", -20).ordered
    read_input("David would gain 75 happiness units by sitting next to George.\nDavid would lose 20 happiness units by sitting next to Mallory.", happiness_table)
  end
end