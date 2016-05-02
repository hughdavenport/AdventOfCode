class StringCounter
  def initialize
    @state = :outside_string
    @raw_code_characters_count = 0
    @represented_string_characters_count = 0
  end

  attr_reader :raw_code_characters_count
  attr_reader :represented_string_characters_count

  def push_character(character)
    if @state == :outside_string
      if character == "\""
        @state = :inside_string
        @raw_code_characters_count += 1
      end
    elsif @state == :inside_string
      @raw_code_characters_count += 1

      if character == "\""
        @state = :outside_string
      elsif character == "\\"
        @state = :inside_string_escape_sequence
      else
        @represented_string_characters_count += 1
      end
    elsif @state == :inside_string_escape_sequence
      @raw_code_characters_count += 1

      if character == "\"" || character == "\\"
        @state = :inside_string
        @represented_string_characters_count += 1
      elsif character == "x"
        @state = :inside_string_hex_escape_sequence_1
      end
    elsif @state == :inside_string_hex_escape_sequence_1
      @raw_code_characters_count += 1
      @state = :inside_string_hex_escape_sequence_2
    elsif @state == :inside_string_hex_escape_sequence_2
      @raw_code_characters_count += 1
      @represented_string_characters_count += 1
      @state = :inside_string
    end
  end
end

class EncodeDifferenceCounter
  def initialize(string)
    @string = string
  end

  def call
    @string.length - @string.gsub(/[\"\\]/,'').length + 2
  end
end


if __FILE__ == $0
  input_file_name = ARGV[0]
  File.open(input_file_name, "r") do |file|
    
    total_re_encoded_count = 0
    string_counter = StringCounter.new
    
    file.each_line do |line|
      line.each_char do |character|
        string_counter.push_character(character)
      end
      puts EncodeDifferenceCounter.new(line).call
      total_re_encoded_count += EncodeDifferenceCounter.new(line).call
    end
    printf("%d %d\n", string_counter.raw_code_characters_count - string_counter.represented_string_characters_count, total_re_encoded_count)
  end
end