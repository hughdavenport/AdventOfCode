require 'rspec'
require_relative '../lights'

RSpec.describe LightMatrix do
  let(:input) { "...\n...\n..." }
  let(:light_matrix) { read_input(input) }

  describe "#neighbors" do
    it "returns neighbors of cell" do
      expect(light_matrix.neighbors([1,1])).to match_array([[0, 0], [0,1], [0,2], [1,0], [1,2], [2,0], [2,1], [2,2]])
    end
  end

  describe "#next_step" do
    context "with middle light turned off and surrounded by 3 neighbors" do
      let(:input) { "...\n#.#\n#.." }

      it "middle light turns on" do
        light_matrix.next_step
        expect(light_matrix.lights[[1,1]]).to be_truthy
      end
    end

    context "with middle light turned on and surrounded by 3 neighbors" do
      let(:input) { "...\n#.#\n#.." }

      it "middle light stays on" do
        light_matrix.next_step
        expect(light_matrix.lights[[1,1]]).to be_truthy
      end
    end

    context "with middle light turned on and surrounded by 1 neighbors" do
      let(:input) { "...\n...\n#.." }

      it "middle light turns off" do
        light_matrix.next_step
        expect(light_matrix.lights[[1,1]]).to be_falsey
      end
    end

    context "with middle light turned on and surrounded by 4 neighbors" do
      let(:input) { ".##\n...\n##." }

      it "middle light turns off" do
        light_matrix.next_step
        expect(light_matrix.lights[[1,1]]).to be_falsey
      end
    end
  end

  let(:expected_steps) do
    [ (".#.#.#\n" +
       "...##.\n" +
       "#....#\n" +
       "..#...\n" +
       "#.#..#\n" +
       "####..") ,
      ("..##..\n" +
       "..##.#\n" +
       "...##.\n" +
       "......\n" +
       "#.....\n" +
       "#.##..")
      ]
  end

  it "simulates expected steps correctly" do
    light_matrix = read_input(expected_steps[0])
    light_matrix.next_step
    expect(light_matrix.lights).to eq(read_input(expected_steps[1]).lights)
  end
end
