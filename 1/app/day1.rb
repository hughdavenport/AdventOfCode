
class Day1
  def initialize(floor_string)
    @floor_string = floor_string
  end
  
  def call
    @floor = 0
    @floor_string.each_char do |char|
      @floor += 1 if char == '('
      @floor -= 1 if char == ')'
    end
    @floor
  end
end
