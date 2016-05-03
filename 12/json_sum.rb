require 'json'
require 'pp'

class ParseAccounts
  def initialize(master, sans_red = false)
    @master = master
    @sans_red = sans_red
  end
  
  def call
    if @master.is_a? Array
      @master.reduce(0) { |current, value| current + ParseAccounts.new(value, @sans_red).call }
    elsif @master.is_a? Hash
      return 0 if @sans_red && @master.any? { |key, value| key == 'red' || value == 'red' }
      @master.reduce(0) { |current, key_value| current + ParseAccounts.new(key_value[1], @sans_red).call }
    elsif @master.is_a? String
      0
    else
      @master
    end
  end
end


if __FILE__ == $0
  input_file_name = ARGV[0]
  File.open(input_file_name) do |file|
    data = JSON.parse(file.read)
    puts "All: #{ParseAccounts.new(data).call}"
    puts "Sans red: #{ParseAccounts.new(data, true).call}"
  end
end
