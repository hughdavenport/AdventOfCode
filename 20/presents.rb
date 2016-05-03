num = ARGV[0].to_i

def get_house_number(target, deliveries, max=nil)
  final_value = 0
  (1..target).each do |house_number|
    count = 0
    (1..Math.sqrt(house_number).to_i).each do |elf_number|
      if house_number % elf_number == 0
        count += elf_number if !max || house_number/elf_number <= max
        
        if elf_number != Math.sqrt(house_number)
          partner_elf = house_number/elf_number
          count += partner_elf if !max || house_number/partner_elf <= max
        end
      end
    end
    count *= deliveries
    puts "House #{house_number} has count: #{count}" if (house_number % 10000) == 0
    
    if count >= target
      final_value = house_number
      break
    end
  end
  return final_value
end

standard = get_house_number(num,10)
puts "Lowest house number for standard deliveries is: #{standard}"
updated = get_house_number(num,11, 50)
puts "Lowest house number for amended deliveries is: #{updated}"