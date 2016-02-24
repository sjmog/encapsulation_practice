# Understands comparing things
module Comparisons
  def max(*others)
    others.flatten!
    return self if others.empty?
    first, *rest = others
    self >= first ? self.max(rest) : first.max(rest)
  end
end