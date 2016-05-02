require_relative 'touch_map'

class DeliveriesWithTwoSantas
  def initialize(input_string)
    @input_string = input_string
  end
  
  def call
    odd_input = @input_string.chars.select.with_index { |_, i| i.odd? }.join
    even_input = @input_string.chars.select.with_index { |_, i| i.even? }.join

    santa = TouchMap.new(odd_input).call
    robo_santa = TouchMap.new(even_input).call

    (santa + robo_santa).size
  end
end