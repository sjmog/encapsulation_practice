# Understands traversal of a graph
class Link
  attr_reader :target, :cost
  protected :cost
  private :target

  MINIMUM_COST = -> (cost) { cost }
  MINIMUM_HOPS = -> (cost) { 1 }

  def initialize(target, cost)
    @target, @cost = target, cost
  end

  def _count(node, strategy, visited_nodes)
    target._count(node, strategy, visited_nodes) + strategy.call(cost)
  end
end
