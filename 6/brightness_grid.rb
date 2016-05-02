
class BrightnessGrid
  def initialize
    @grid = Array.new(1000) { Array.new(1000) { 0 } }
  end

  def turn_on(left, top, right, bottom)
    step_through(left, top, right, bottom) { |current| current+1 }
  end

  def turn_off(left, top, right, bottom)
    step_through(left, top, right, bottom) { |current| [current-1, 0].max }
  end

  def toggle(left, top, right, bottom)
    step_through(left, top, right, bottom) { |current| current+2 }
  end

  def total_brightness
    count = 0
    step_through(0,0,999,999) do |current|
      count += current
      current
    end
    count
  end

  private

  def step_through(left, top, right, bottom)
    (left..right).each do |x|
      (top..bottom).each do |y|
        @grid[x][y] = yield @grid[x][y]
      end
    end
  end
end