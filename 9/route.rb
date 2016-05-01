class DistanceGraph
  def initialize
    @distances = {}
  end

  def add_distance(from, to, distance)
    @distances[ [from, to] ] = distance
    @distances[ [to, from] ] = distance
  end

  def nodes
    @distances.map { |from_to_pair, value| from_to_pair }.flatten.uniq
  end

  def distance(from, to)
    @distances[ [from, to] ]
  end

  def path_length(path)
    length = 0
    path.each_cons(2) do |node1, node2|
      length += distance(node1, node2)
    end
    length
  end
end

def read_input(input_text)
  distance_graph = DistanceGraph.new

  input_text.split("\n").each do |line|
    input_line_regex = /(.*) to (.*) = (.*)/
    match = input_line_regex.match(line)
    distance_graph.add_distance(match[1], match[2], match[3].to_i)
  end

  distance_graph
end

def solve_shortest_path(distance_graph)
  distance_graph.nodes.permutation.sort { |path1, path2| distance_graph.path_length(path1) <=> distance_graph.path_length(path2) }.first
end

if __FILE__ == $0
  input_file_name = ARGV[0]
  File.open(input_file_name, "r") do |file|
    distance_graph = read_input(file.read)
    shortest_path = solve_shortest_path(distance_graph)
    printf("%d\n", distance_graph.path_length(shortest_path))
  end
end