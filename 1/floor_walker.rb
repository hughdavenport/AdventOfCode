class FloorWalker
  def initialize(floor_string)
    @floor_string = floor_string
  end

  attr_reader :final_floor
  attr_reader :position_on_entering_basement

  def call
    @final_floor = 0
    @floor_string.chars.each_with_index do |char, index|
      @final_floor += 1 if char == '('
      @final_floor -= 1 if char == ')'
      if @final_floor == -1 && @position_on_entering_basement.nil?
        @position_on_entering_basement = index + 1
      end
    end
    self
  end
end
