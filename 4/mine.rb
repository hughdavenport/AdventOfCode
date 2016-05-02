require 'openssl'

class Mine
  def initialize(input_string, leading_zeroes_count)
    @input_string = input_string
    @leading_zeroes_count = leading_zeroes_count
  end
  
  def call
    @value = 1
    @digest = current_MD5
    while @digest.chars[0, @leading_zeroes_count] != (['0'] * @leading_zeroes_count)
      @value += 1
      puts(@value) if (@value % 5000) == 0
      @digest = current_MD5
    end
    
    @value
  end
  
  def current_MD5
    OpenSSL::Digest::MD5.hexdigest(@input_string + @value.to_s)
  end
end