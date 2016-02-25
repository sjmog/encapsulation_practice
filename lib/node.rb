require_relative './link'

# Understands connections to other Nodes
class Node
  UNREACHABLE = Float::INFINITY
  attr_reader :links
  protected :links

  def initialize
    @links = []
  end

  def >(neighbour_cost_pair)
    links << Link.new(*neighbour_cost_pair)
    neighbour_cost_pair.first
  end

  def reach?(other)
    _count(other) != UNREACHABLE
  end

  def hop_count(other)
    handle_result(_count(other, Link::MINIMUM_HOPS))
  end

  def cost(other)
    handle_result(_count(other, Link::MINIMUM_COST))
  end

  def _count(other, strategy = Link::MINIMUM_HOPS, visited_nodes = [])
    return 0 if self == other
    return UNREACHABLE if visited_nodes.include? self
    links.map do |link|
      link._count(other, strategy, visited_nodes.dup << self)
    end.min || UNREACHABLE
  end

  private

  def handle_result(result)
    raise 'Cannot find destination' if result == UNREACHABLE
    result.to_i
  end
end
