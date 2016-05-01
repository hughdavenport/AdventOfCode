class WrappingPaper
  def initialize(length, width, height)
    @length = length
    @width = width
    @height = height
  end
  
  def call
    sides = [@length * @width, @width * @height, @height * @length]
    sides.min + 2 * sides.reduce(:+)
  end
end


