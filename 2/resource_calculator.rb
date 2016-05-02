class ResourceCalculator
  def initialize(length, width, height)
    @length = length
    @width = width
    @height = height
  end

  attr_reader :wrapping_paper
  attr_reader :ribbon

  def call
    sides = [@length * @width, @width * @height, @height * @length]
    @wrapping_paper = sides.min + 2 * sides.reduce(:+)

    shortest_sides = [@length, @width, @height].sort.take(2)
    wrap_ribbon = shortest_sides.reduce(:+) * 2
    bow_ribbon = @length * @width * @height
    @ribbon = wrap_ribbon + bow_ribbon

    self
  end
end