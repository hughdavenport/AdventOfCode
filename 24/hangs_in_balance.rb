def read_input(input_string)
  package_weights = []
  input_string.each_line { |line| package_weights << line.to_i }
  package_weights
end

def find_first_compartment_arragement(package_weights, compartment_size)
  package_count = package_weights.size

  Enumerator.new do |values|
    (1..package_count).each do |first_compartment_size|
      package_weights.combination(first_compartment_size).each do |first_compartment_packages|
        if first_compartment_packages.inject(0, :+) == compartment_size
          values << first_compartment_packages
        end
      end
    end
  end
end

def find_other_compartments_arragement(remaining_packages, compartment_size)
  sorted_remaining_packages = remaining_packages.sort.reverse

  second_compartment = []
  sorted_remaining_packages.each do |package|
    second_compartment << package
    if second_compartment.inject(0, :+) == compartment_size
      return second_compartment
    else
      second_compartment.pop
    end
  end
end

def quantum_entanglement(packages)
  packages.inject(1, :*)
end

if __FILE__ == $0
  input_file_name = ARGV[0]
  package_weights = read_input(File.read(input_file_name))
  compartment_size = package_weights.inject(0, :+) / 3

  find_first_compartment_arragement(package_weights, compartment_size).each do |first_compartment|
    remaining_packages = package_weights.reject { |package| first_compartment.include?(package) }
    second_compartment = find_other_compartments_arragement(remaining_packages, compartment_size)
    if second_compartment
      third_compartment = package_weights.reject { |package| first_compartment.include?(package) || second_compartment.include?(package) }
      puts "Found complete arrangement for 3 compartments: #{first_compartment}, #{second_compartment}, #{third_compartment}, QE: #{quantum_entanglement(first_compartment)}"
      break
    end
  end


  compartment_size = package_weights.inject(0, :+) / 4

  find_first_compartment_arragement(package_weights, compartment_size).each do |first_compartment|
    remaining_packages = package_weights.reject { |package| first_compartment.include?(package) }

    second_compartment = find_other_compartments_arragement(remaining_packages, compartment_size)
    if second_compartment
      remaining_packages = package_weights.reject { |package| first_compartment.include?(package) || second_compartment.include?(package) }
      third_compartment = find_other_compartments_arragement(remaining_packages, compartment_size)
      if third_compartment
        fourth_compartment = package_weights.reject { |package| first_compartment.include?(package) || second_compartment.include?(package) || third_compartment.include?(package) }
        puts "Found complete arrangement for 4 compartments: #{first_compartment}, #{second_compartment}, #{third_compartment}, #{fourth_compartment}, QE: #{quantum_entanglement(first_compartment)}"
        break
      end
    end
  end
end