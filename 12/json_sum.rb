if __FILE__ == $0
  input_file_name = ARGV[0]
  File.open(input_file_name, "r") do |file|
    sum = 0
    file.read.scan(/(-?)([0-9]+)/).each do |match|
      sign = match[0]
      number = match[1].to_i
      number *= -1 if sign == '-'
      sum += number
    end
    printf("%d\n", sum)
  end
end