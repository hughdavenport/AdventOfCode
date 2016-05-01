require 'openssl'

class Mine
  def initialize(input_string)
    @input_string = input_string
  end
  
  def call
    @value = 1
    @digest = current_MD5
    while @digest.slice(0,5) != '00000'
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