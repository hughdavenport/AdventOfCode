require 'rspec'
require_relative '../route'

RSpec.describe DistanceGraph do
  it "stores distances" do
    distance_graph = DistanceGraph.new
    distance_graph.add_distance('a', 'b', 10)
    expect(distance_graph.distance('a', 'b')).to eq(10)
    expect(distance_graph.distance('b', 'a')).to eq(10)
  end

  it "returns list of unique nodes" do
    distance_graph = DistanceGraph.new
    distance_graph.add_distance('a', 'b', 10)
    distance_graph.add_distance('b', 'c', 20)
    expect(distance_graph.nodes).to match_array(['a', 'b', 'c'])
  end

  it "returns a length of path following the nodes" do
    distance_graph = DistanceGraph.new
    distance_graph.add_distance('a', 'b', 10)
    distance_graph.add_distance('b', 'c', 20)
    distance_graph.add_distance('c', 'd', 30)

    expect(distance_graph.path_length(['a', 'b', 'c', 'd'])).to eq(60)
  end
end