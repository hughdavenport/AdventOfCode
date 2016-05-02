class LightMatrix
  def initialize
    @lights = {}
  end

  def lights_on
    @lights.count { |_, on| on }
  end

  def set_light(x, y, on)
    @lights[[x,y]] = on
    @max_x = [x, @max_x || 0].max
    @max_y = [y, @max_y || 0].max
  end

  def next_step
    next_lights = @lights.clone

    @lights.keys.each do |coord|
      neighbors_on = neighbors(coord).map { |neighbor_coord| @lights[neighbor_coord] }.count { |on| on }
      current_on = @lights[coord]
      if current_on && ![2,3].include?(neighbors_on)
        next_lights[coord] = false
      elsif !current_on && neighbors_on == 3
        next_lights[coord] = true
      end
    end

    @lights = next_lights
  end

  def neighbors(coord)
    neighbors = []
    [-1, 0, 1].each do |x|
      [-1, 0, 1].each do |y|
        next if x == 0 && y == 0
        coords = [coord[0] + x, coord[1] + y]
        next if coords[0] < 0 || coords[0] > @max_x
        next if coords[1] < 0 || coords[1] > @max_y
        neighbors << coords
      end
    end
    neighbors
  end

  def to_s
    str = ""
    (0..@max_y).each do |y|
      (0..@max_x).each do |x|
        str += @lights[[x,y]] ? "#" : "."
      end
      str += "\n"
    end
    str
  end

  attr_reader :lights
end

def read_input(input)
  light_matrix = LightMatrix.new

  input.each_line.with_index do |line, y|
    line.chomp.each_char.with_index do |char, x|
      light_matrix.set_light(x, y, char == '#')
    end
  end

  light_matrix
end

if __FILE__ == $0
  input_file_name = ARGV[0]
  input = File.read(input_file_name)
  light_matrix = read_input(input)

  100.times { light_matrix.next_step }

  puts "Lights turned on after 100 iterations: #{light_matrix.lights_on}"
end