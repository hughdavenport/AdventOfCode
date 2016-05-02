require 'rspec'
require_relative '../next_password'

RSpec.describe '#password_string_to_password_number' do
  it "returns the password converted to number" do
    expect(password_string_to_password_number("a")).to eq(0)
    expect(password_string_to_password_number("z")).to eq(25)
    expect(password_string_to_password_number("ba")).to eq(26)
    expect(password_string_to_password_number("cba")).to eq(2*26*26 + 1*26 + 0)
  end
end

RSpec.describe '#password_number_to_password_string' do
  it "returns the number converted to string" do
    expect(password_number_to_password_string(0)).to eq("a")
    expect(password_number_to_password_string(25)).to eq("z")
    expect(password_number_to_password_string(26)).to eq("ba")
    expect(password_number_to_password_string(2*26*26 + 1*26 + 0)).to eq("cba")
  end
end

RSpec.describe "#contains_forbidden_letters?" do
  it "returns true if password contains any of the forbidden letters" do
    expect(contains_forbidden_letters?("aaa")).to be_falsey
    expect(contains_forbidden_letters?("aaai")).to be_truthy
    expect(contains_forbidden_letters?("aaal")).to be_truthy
    expect(contains_forbidden_letters?("aaao")).to be_truthy
  end
end

RSpec.describe "#grouped_elements" do
  it "returns list of same element groups" do
    expect(grouped_elements(%w{a a b c c c})).to eq([%w{a a}, %w{b}, %w{c c c}])
  end
end

RSpec.describe "#is_increasing_sequence?" do
  it "returns true for increasing sequences of characters" do
    expect(is_increasing_sequence?(%w{a b a})).to be_falsey
    expect(is_increasing_sequence?(%w{a b c})).to be_truthy
  end
end

RSpec.describe "#contains_increasing_three_letter_sequence?" do
  it "returns true if password contains a sequence of three increasing letters" do
    expect(contains_increasing_three_letter_sequence?("aabba")).to be_falsey
    expect(contains_increasing_three_letter_sequence?("aabca")).to be_truthy
  end
end

RSpec.describe "#password_contains_two_pairs_of_same_letters?" do
  it "returns true if password contains at least two pairs of same letters" do
    expect(password_contains_two_pairs_of_same_letters?("aaaa")).to be_falsey
    expect(password_contains_two_pairs_of_same_letters?("aabaa")).to be_falsey
    expect(password_contains_two_pairs_of_same_letters?("aabcc")).to be_truthy
  end
end