# Understands connections to other Nodes
class Node
  UNREACHABLE = Float::INFINITY
  attr_reader :neighbours
  protected :neighbours

  def initialize
    @neighbours = []
  end

  def >(other)
    neighbours << other
    other
  end

  def reach?(other)
    recursive_hop_count(other) != UNREACHABLE
  end

  def hop_count(other)
    result = recursive_hop_count(other)
    raise 'Cannot find destination' if result == UNREACHABLE
    result
  end

  protected

  def recursive_hop_count(other, visited_nodes = [])
    return 0 if self == other
    return UNREACHABLE if visited_nodes.include?(self)
    neighbours.map do |node|
      node.recursive_hop_count(other, visited_nodes.dup << self) + 1
    end.min || UNREACHABLE
  end
end