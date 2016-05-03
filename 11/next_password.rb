def password_string_to_password_number(password_string)
  password_number = 0
  current_multiplier = 1
  password_string.chars.reverse.each do |char|
    password_number += (char.ord - 'a'.ord) * current_multiplier
    current_multiplier *= 26
  end

  password_number
end

def password_number_to_password_string(password_number)
  return "a" if password_number == 0

  password_string = ""
  remaining_password_number = password_number
  while remaining_password_number != 0
    letter = ("a".ord + (remaining_password_number % 26)).chr
    remaining_password_number /= 26
    password_string = letter + password_string
  end
  password_string
end

def contains_forbidden_letters?(password_string)
  ["i", "o", "l"].any? { |letter| password_string.include?(letter) }
end

def is_increasing_sequence?(chars)
  chars.each_cons(2).to_a.all? { |ch1, ch2| ch1.ord+1 == ch2.ord }
end

def contains_increasing_three_letter_sequence?(password_string)
  password_string.chars.each_cons(3).to_a.any?(&method(:is_increasing_sequence?))
end

def grouped_elements(array)
  all_groups = []

  group = []
  array.each do |element|
    if group.empty? || group.last == element
      group << element
    else
      all_groups << group
      group = [element]
    end
  end

  all_groups << group unless group.empty?

  all_groups
end

def password_contains_two_pairs_of_same_letters?(password_string)
  grouped_elements(password_string.chars).select { |group| group.length >= 2 && group[0] == group[1] }.uniq.count >= 2
end

def password_good?(password_string)
  return false unless contains_increasing_three_letter_sequence?(password_string)
  return false if contains_forbidden_letters?(password_string)
  return false unless password_contains_two_pairs_of_same_letters?(password_string)
  return true
end

def increment_password(password_string)
  password_number = password_string_to_password_number(password_string)

  password_number += 1
  password_number += 1 until password_good?(password_number_to_password_string(password_number))

  password_number_to_password_string(password_number)
end

if __FILE__ == $0
  input_password = File.read(ARGV[0]).chomp

  next_password = increment_password(input_password)
  puts "Next password: #{next_password}"

  yet_another_password = increment_password(next_password)
  puts "Yet another password: #{yet_another_password}"
end
