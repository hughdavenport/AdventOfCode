
$gate_set = {}


class Copy
  def initialize(name, a)
    $gate_set[name] = self
    @a = a
  end
  
  def call
    #puts "copy: @a"
    @value ||= $gate_set[@a].call
  end
end

class And
  def initialize(name, a, b)
    $gate_set[name] = self
    @a = a
    @b = b
  end
  
  def call
    #puts "and: #{@a}, #{@b}"
    @value ||= $gate_set[@a].call & $gate_set[@b].call
  end
end

class Or
  def initialize(name, a, b)
    $gate_set[name] = self
    @a = a
    @b = b
  end
  
  def call
    #puts "or:  #{@a}, #{@b}"
    @value ||= $gate_set[@a].call | $gate_set[@b].call
  end
end

class Not
  def initialize(name, a)
    $gate_set[name] = self
    @a = a
  end

  def call
    #puts "not: #{@a}"
    @value ||= $gate_set[@a].call ^ 0xffff
  end
end

class LShift
  def initialize(name, a, amount)
    $gate_set[name] = self
    @a = a
    @amount = amount
  end
  
  def call
    @value ||= ($gate_set[@a].call << @amount) & 0xffff
  end
end


class RShift
  def initialize(name, a, amount)
    $gate_set[name] = self
    @a = a
    @amount = amount
  end
  
  def call
    #puts "r shift: #{@a}, #{@amount}"
    @value ||= $gate_set[@a].call >> @amount
  end
end

class Value
  def initialize(name, value)
    $gate_set[name] = self
    @value = value
  end
  
  def call
    #puts "value: #{@value}"
    @value
  end
end