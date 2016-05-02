class LookAndSayGenerator
  attr_reader :string
  
  def initialize(string = '1')
    @string = string
  end
  
  def call
    result = ''
    active_char = nil
    active_count = 0
    @string.each_char.with_index do |char, index|
      if index == 0 || active_char != char
        result << active_count.to_s + active_char if index > 0
        active_char = char
        active_count = 1
      else
        active_count += 1
      end
    end
    result << active_count.to_s + active_char
  end
end

if __FILE__ == $0
  input_string = '1321131112'
  generator = LookAndSayGenerator.new(input_string)
  
  50.times do |num| 
    generator = LookAndSayGenerator.new(generator.call) 
    printf("\rCalculating... %d / 40", num)
  end
  printf("\r\n%d\n", generator.string.length)
end