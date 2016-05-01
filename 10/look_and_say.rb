class LookAndSayGenerator
  def initialize(number = 1)
    @number = number
  end

  attr_reader :number

  def next
    new_number = ""
    grouped_digits(@number).each do |digit_group|
      new_number += digit_group.length.to_s
      new_number += digit_group.first.to_s
    end
    @number = new_number.to_i
  end
end

def digits(number)
  number.to_s.chars.map(&:to_i)
end

def grouped_digits(number)
  all_digit_groups = []

  digits_group = []
  digits(number).each do |digit|
    if digits_group.empty? || digits_group.last == digit
      digits_group << digit
    else
      all_digit_groups << digits_group
      digits_group = [digit]
    end
  end

  all_digit_groups << digits_group unless digits_group.empty?

  all_digit_groups
end

if __FILE__ == $0
  input_number = 3113322113
  generator = LookAndSayGenerator.new(input_number)
  40.times { |num| generator.next; printf("\rCalculating... %d / 40", num); }
  printf("\r%d\n", generator.number.to_s.length)
end