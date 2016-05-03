num = ARGV[0].to_i

def get_factors(num)
  val = sqrt(num)
  while val < num
    
  end
end


(1..num).each do |house_number|
  count = 0
  (1..Math.sqrt(house_number).to_i).each do |elf_number|
    if house_number % elf_number == 0
      count += elf_number
      count += house_number/elf_number if elf_number != Math.sqrt(house_number)
    end
  end
  count *= 10
  puts "House #{house_number} has count: #{count}" if (house_number % 10000) == 0
  if count >= num
    puts "Lowest house number is #{house_number}"
    break
  end
end
