require_relative '../gates'

RSpec.describe 'Gates' do
  
  context 'temp' do
    
    LShift.new(:f, :x, 2)
    RShift.new(:g, :y, 2)
    Value.new(:x, 123)
    Value.new(:y, 456)
    And.new(:d, :x, :y)
    Or.new(:e, :x, :y)
    Not.new(:h, :x)
    Not.new(:i, :y)
    
    $gate_set.each { |k,v| puts "#{k} = #{v.call}" }
  end
  
end