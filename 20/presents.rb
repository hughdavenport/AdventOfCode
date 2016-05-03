num = ARGV[0].to_i

(1..num).each do |house_number|
  count = 0
  (1..house_number).each do |elf_number|
    count += elf_number * 10 if house_number % elf_number == 0
  end
  puts "House #{house_number} has count: #{count}"
  if count >= num
    puts "Lowest house number is #{house_number}"
    break
  end
end
