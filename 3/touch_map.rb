require 'set'

class TouchMap
  def initialize(input_string)
    @input_string = input_string
  end
  
  def call
    @set = Set.new
    current = [0,0]
    @set << current.dup
    
    @input_string.each_char do |char|
      current[0] += 1 if char == '>'
      current[0] -= 1 if char == '<'
      current[1] += 1 if char == 'v'
      current[1] -= 1 if char == '^'
      @set << current.dup
    end
    @set
  end
end