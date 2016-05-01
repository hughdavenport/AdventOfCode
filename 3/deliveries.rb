require_relative 'touch_map'

class Deliveries
  def initialize(input_string)
    @input_string = input_string
  end
  
  def call
    TouchMap.new(@input_string).call.size
  end
end