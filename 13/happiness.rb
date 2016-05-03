class HappinessTable
  def initialize
    @happiness_info = {}
  end

  def add_happiness_condition(person, neighbor, delta_happiness)
    @happiness_info[person] ||= {}
    @happiness_info[person][neighbor] = delta_happiness
  end

  def persons
    @happiness_info.keys
  end

  def happiness_factor(arrangement)
    total_happiness_factor = 0

    circular_arrangement = [arrangement.last] + arrangement + [arrangement.first]
    circular_arrangement.each_cons(3) do |neighbor_left, person, neighbor_right|
      total_happiness_factor += @happiness_info[person][neighbor_left]
      total_happiness_factor += @happiness_info[person][neighbor_right]
    end

    total_happiness_factor
  end

  def find_best_arrangement
    persons.permutation.map(&method(:happiness_factor)).max
  end
end

def read_input(input_text, happiness_table, add_me = false)
  input_text.split("\n").each do |line|
    match = line.match(/(.*) would (gain|lose) (.*) happiness units by sitting next to (.*)./)
    person = match[1]
    gain_or_lose = match[2]
    delta_happiness = match[3].to_i
    delta_happiness *= -1 if gain_or_lose == 'lose'
    neighbor = match[4]
    happiness_table.add_happiness_condition(person, neighbor, delta_happiness)
    if add_me
      happiness_table.add_happiness_condition("Me", person, 0)
      happiness_table.add_happiness_condition(person, "Me", 0)
    end
  end
end

if __FILE__ == $0
  input_file_name = ARGV[0]
  File.open(input_file_name, "r") do |file|
    happiness_table = HappinessTable.new
    read_input(file.read, happiness_table)
    printf("Without you: %d\n", happiness_table.find_best_arrangement)
    file.rewind
    read_input(file.read, happiness_table,true )
    printf("With you: %d\n", happiness_table.find_best_arrangement)
  end
end