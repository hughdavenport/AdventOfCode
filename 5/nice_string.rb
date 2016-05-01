class NiceString
  def initialize(input_string)
    @input_string = input_string
  end
  
  def call
    vowels = @input_string.gsub(/[^aeiou]/,'').length >= 3
    has_double = double_letter(@input_string)
    no_bad_pair = @input_string.sub(/(?:ab|cd|pq|xy)/,'') == @input_string
    
    vowels && has_double && no_bad_pair
  end
  
  def double_letter(str)
    str.each_char.with_index.any? do |char, index|
      if index > 0
        char == str[index-1]
      end
    end
  end
end