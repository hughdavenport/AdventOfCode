require_relative '../brightness_grid'

RSpec.describe BrightnessGrid do
  subject(:brightness_grid) { BrightnessGrid.new }

  [ { turn_on: [0,0,999,999] },
    { toggle: [0,0,999,0] },
    { turn_off: [499,499,500,500] }
  ].each.with_index do |input, index|
    context 'with all off and input #{input}' do
      expected_result = [1000000, 2000, 0]

      it "total brightness is #{expected_result[index]}" do
        input.each do |key, points|
          brightness_grid.method(key).call(*points)
          expect(brightness_grid.total_brightness).to eq(expected_result[index])
        end
      end
    end

    context 'with all on and input #{input}' do
      before(:each) { brightness_grid.turn_on(0,0,999,999) }
      expected_result = [2000000, 1002000, 999996]

      it "total brightness is #{expected_result[index]}" do
        input.each do |key, points|
          brightness_grid.method(key).call(*points)
          expect(brightness_grid.total_brightness).to eq(expected_result[index])
        end
      end
    end
  end
end