require 'set'
@min_found = nil
def flip(transitions)
  ret = Hash.new
  transitions.each do |start, finish_array|
    finish_array.each do |finish|
      ret[finish] = [] unless ret.include?(finish)
      ret[finish] << start
    end
  end
  ret.sort_by { |key, value| key.length }.reverse.to_h
end

@seen = {}
def goback(molecule, transitions)
  number_of_times = caller.select { |line| line.include?("in `goback'") }.length
  return if @min_found && number_of_times > @min_found
  if molecule == "e"
    puts "Number of times is #{number_of_times}" if !@min_found || number_of_times < @min_found
    @min_found = [@min_found ? @min_found : number_of_times, number_of_times].min
    return 0
  end
  if molecule.include?("e")
    puts "OMGBAD!!!"
    return
  end

  if @seen.include?(molecule)
    return @seen[molecule]
  end

  min = nil
  transitions.each do |start, finish_array|
    index = molecule.index(start)
    while !index.nil?
      finish_array.each do |finish|
        previous_molecule = (molecule[0...index] + finish + molecule[(index+start.length)..-1])
        ret = goback(previous_molecule, transitions)
        min = [min ? min : ret, ret].min
      end
      index = molecule.index(start, index + 1)
    end
  end
  @seen[molecule] = min
  return min
end

if __FILE__ == $0
  input_file_name = ARGV[0]
  first_section = true
  transitions = {}
  File.open(input_file_name) do |file|
    file.each_line do |line|
      if line.chomp.empty?
        first_section = false
        next
      end
      if first_section
        parts = line.chomp.split(' => ')
        transitions[parts[0]] = [] unless transitions.include?(parts[0])
        transitions[parts[0]] << parts[1]
      else
        molecule = line.chomp
        next_molecules = Set.new
        transitions.each do |start, finish_array|
          index = molecule.index(start)
          while !index.nil?
            finish_array.each do |finish|
              next_molecules << (molecule[0...index] + finish + molecule[(index+start.length)..-1])
            end
            index = molecule.index(start, index + 1)
          end
        end
        puts "Distinct molecules: #{next_molecules.length}"
        p goback(molecule, flip(transitions))
      end
    end
  end
end
