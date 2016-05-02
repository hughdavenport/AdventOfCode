class LightMatrix
  def initialize(keep_corners_on = false)
    @lights = {}
    @keep_corners_on = keep_corners_on
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
    set_corners_on if @keep_corners_on

    old_lights = @lights.clone

    old_lights.keys.each do |coord|
      neighbors_on = neighbors(coord).map { |neighbor_coord| old_lights[neighbor_coord] }.count { |on| on }
      current_on = old_lights[coord]
      if current_on && ![2,3].include?(neighbors_on)
        set_light(*coord, false)
      elsif !current_on && neighbors_on == 3
        set_light(*coord, true)
      end
    end

    set_corners_on if @keep_corners_on
  end

  def set_corners_on
    @lights[[0,0]] = true
    @lights[[@max_x,0]] = true
    @lights[[@max_x,@max_y]] = true
    @lights[[0,@max_y]] = true
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

def read_input(input, light_matrix)
  input.each_line.with_index do |line, y|
    line.chomp.each_char.with_index do |char, x|
      light_matrix.set_light(x, y, char == '#')
    end
  end
end

if __FILE__ == $0
  input_file_name = ARGV[0]
  input = File.read(input_file_name)

  light_matrix = LightMatrix.new
  read_input(input, light_matrix)

  100.times { light_matrix.next_step }

  puts "Lights turned on after 100 iterations: #{light_matrix.lights_on}"

  light_matrix_corners_on = LightMatrix.new(true)
  read_input(input, light_matrix_corners_on)

  100.times { light_matrix_corners_on.next_step }

  puts "Lights turned on after 100 iterations with keeping corners on: #{light_matrix_corners_on.lights_on}"
end