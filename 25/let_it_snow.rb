def iteration_for_coords(coords)
  y, x = coords

  current_x = current_y = 1
  iteration = 1

  while current_x != x || current_y != y
    iteration += 1

    if current_y == 1
      current_y = current_x + 1
      current_x = 1
    else
      current_x += 1
      current_y -= 1
    end
  end

  iteration
end

def next_number_in_sequence(current_number)
  (current_number * 252533) % 33554393
end

def read_input(input_string)
  match = input_string.match(/To continue, please consult the code grid in the manual.  Enter the code at row (.*), column (.*)./)
  [match[1].to_i, match[2].to_i]
end

if __FILE__ == $0
  input_file_name = ARGV[0]
  coords = read_input(File.read(input_file_name))
  iterations = iteration_for_coords(coords)
  current_number = 20151125
  (iterations-1).times { current_number = next_number_in_sequence(current_number) }
  puts "Number in sequence at #{coords}, sequence iteration: #{iterations}: #{current_number}"
end