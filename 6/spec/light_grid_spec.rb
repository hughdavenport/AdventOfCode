require_relative '../light_grid'

RSpec.describe LightGrid do
  subject(:light_grid) { LightGrid.new }
  
  [ { turn_on: [0,0,999,999] },
    { toggle: [0,0,999,0] },
    { turn_off: [499,499,500,500] }
  ].each.with_index do |input, index|
    context 'with all off and input #{input}' do
      expected_result = [1000000, 1000, 0]
      
      it "#{expected_result[index]} are on" do
        input.each do |key, points|
          light_grid.method(key).call(*points)
          expect(light_grid.total_turned_on).to eq(expected_result[index])
        end
      end
    end
    
    context 'with all on and input #{input}' do
      before(:each) { light_grid.turn_on(0,0,999,999) }
      expected_result = [1000000, 999000, 999996]
      
      it "#{expected_result[index]} are on" do
        input.each do |key, points|
          light_grid.method(key).call(*points)
          expect(light_grid.total_turned_on).to eq(expected_result[index])
        end
      end
    end
    
  end
end