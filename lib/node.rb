# Understands connections to other Nodes
class Node
  def initialize
    @neighbours = []
  end

  def >(other)
    @neighbours << other
    other
  end

  def reach?(other, visited = [])
    return true if other == self

    @neighbours.any? do |node|
      next if visited.include? node
      node.reach?(other, (visited << node))
    end
  end
end