require_relative 'gates'

$next_blank_val = 1

class Parser
  def initialize(line)
    @line = line
  end
  
  def call
    match_value = /^(\d+) -> ([a-z]+)/.match(@line)
    match_not = /^NOT ([a-z]+) -> ([a-z]+)/.match(@line)
    match_and = /^([a-z]+) AND ([a-z]+) -> ([a-z]+)/.match(@line)
    match_or = /^([a-z]+) OR ([a-z]+) -> ([a-z]+)/.match(@line)
    match_left = /^([a-z]+) LSHIFT (\d+) -> ([a-z]+)/.match(@line)
    match_right = /^([a-z]+) RSHIFT (\d+) -> ([a-z]+)/.match(@line)
    match_val_and = /^(\d+) AND ([a-z]+) -> ([a-z]+)/.match(@line)
    match_copy = /^([a-z]+) -> ([a-z]+)/.match(@line)
    
    if match_value
      Value.new(match_value[2], match_value[1].to_i)
    elsif match_not
      Not.new(match_not[2], match_not[1])
    elsif match_and
      And.new(match_and[3], match_and[1], match_and[2])
    elsif match_or
      Or.new(match_or[3], match_or[1], match_or[2])
    elsif match_left
      LShift.new(match_left[3], match_left[1], match_left[2].to_i)
    elsif match_right
      RShift.new(match_right[3], match_right[1], match_right[2].to_i)
    elsif match_val_and
      Value.new($next_blank_val, match_val_and[1].to_i)
      And.new(match_val_and[3], $next_blank_val, match_val_and[2])
      $next_blank_val += 1
    elsif match_copy
      Copy.new(match_copy[2], match_copy[1])
    else
      raise "Nothing matched: #{@line}"
    end
  end
end