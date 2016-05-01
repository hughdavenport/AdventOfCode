require 'rspec'
require_relative '../strings'

RSpec.describe StringCounter do
  let(:string_counter) { StringCounter.new }

  before do
    string.each_char { |ch| string_counter.push_character(ch) }
  end

  context "code without string literals" do
    let(:string) { " \n" }

    it "returns 0 and 0" do
      expect(string_counter.raw_code_characters_count).to eq(0)
      expect(string_counter.represented_string_characters_count).to eq(0)
    end
  end

  context "code with empty string literal" do
    let(:string) { %{""} }

    it "returns 2 and 0" do
      expect(string_counter.raw_code_characters_count).to eq(2)
      expect(string_counter.represented_string_characters_count).to eq(0)
    end
  end

  context "code with simple string literal" do
    let(:string) { %{"abc"} }

    it "returns 5 and 3" do
      expect(string_counter.raw_code_characters_count).to eq(5)
      expect(string_counter.represented_string_characters_count).to eq(3)
    end
  end

  context "code with escaped quotation mark" do
    let(:string) { %{"abc\\"def"} }

    it "returns 10 and 7" do
      expect(string_counter.raw_code_characters_count).to eq(10)
      expect(string_counter.represented_string_characters_count).to eq(7)
    end
  end

  context "code with escaped slash" do
    let(:string) { %{"abc\\\\def"} }

    it "returns 10 and 7" do
      expect(string_counter.raw_code_characters_count).to eq(10)
      expect(string_counter.represented_string_characters_count).to eq(7)
    end
  end

  context "code with escaped hex code" do
    let(:string) { %{"abc\\x98def"} }

    it "returns 12 and 7" do
      expect(string_counter.raw_code_characters_count).to eq(12)
      expect(string_counter.represented_string_characters_count).to eq(7)
    end
  end
end