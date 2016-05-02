gift = {
  children: 3,
  cats: 7,
  samoyeds: 2,
  pomeranians: 3,
  akitas: 0,
  vizslas: 0,
  goldfish: 5,
  trees: 3,
  cars: 2,
  perfumes: 1,
}

if __FILE__ == $0
  input_file_name = ARGV[0]
  part1 = false
  part2 = false
  File.open(input_file_name) do |file|
    file.each_line do |line|
      match = /Sue (\d+): (\w*): (\d+), (\w*): (\d+), (\w*): (\d+)/.match(line)
      sue = match[1].to_i
      things = [match[2, 3], match[4,2], match[6,2]].map { |key,value| [key.to_sym, value.to_i] }.to_h

      if things.all? { |key, value| gift[key] == value }
        puts "Part 1: Sue #{sue}"
        part1 = true
      end

      result = things.all? do |key, value|
        if key == :cats || key == :trees
          gift[key] < value
        elsif key == :pomeranians || key == :goldfish
          gift[key] > value
        else
          gift[key] == value
        end
      end

      if result
        puts "Part 2: Sue #{sue}"
        part2 = true
      end

      break if part1 && part2
    end
  end
end
