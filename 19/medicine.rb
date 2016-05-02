require 'set'
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
      end
    end
  end
end
