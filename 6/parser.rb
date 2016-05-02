
class Parser
  def initialize(line)
    @line = line
  end
  
  def call
    m = (/(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)/.match(@line))
    raise "junk: #{@line}" unless m
    hash = Hash.new
    hash[m[1].gsub(' ', '_')] = [m[2].to_i, m[3].to_i, m[4].to_i, m[5].to_i]
    
    hash
  end
end