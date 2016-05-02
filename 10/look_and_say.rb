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
  input_file_name = ARGV[0]
  input_string = File.read(input_file_name).chomp

  generator = LookAndSayGenerator.new(input_string)

  40.times do |num|
    generator = LookAndSayGenerator.new(generator.call)
    printf("\rCalculating... %d / 40", num)
  end
  printf("\nValue at 40: %d\n", generator.string.length)

  10.times do |num|
    generator = LookAndSayGenerator.new(generator.call)
    printf("\rCalculating... %d / 10", num)
  end

  printf("\nValue at 50: %d\n", generator.string.length)
end
