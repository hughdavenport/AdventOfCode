
class LightGrid
  def initialize
    @grid = Array.new(1000) { Array.new(1000) { false } }
  end
  
  def turn_on(left, top, right, bottom)
    step_through(left, top, right, bottom) { |current| true }
  end
  
  def turn_off(left, top, right, bottom)
    step_through(left, top, right, bottom) { |current| false }
  end
  
  def toggle(left, top, right, bottom)
    step_through(left, top, right, bottom) { |current| ! current }
  end
  
  def on
    count = 0
    step_through(0,0,999,999) do |current| 
      count += 1 if current
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