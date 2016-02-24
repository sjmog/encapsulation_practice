require_relative './comparisons'
# Understand likelihood of something occurring
class Possibility
  include Comparisons

  NORMALIZED_WEIGHT = 1
  attr_reader :weight
  protected :weight

  def initialize(weight:)
    raise 'Not permitted' if weight > NORMALIZED_WEIGHT
    raise 'Not permitted' if weight < 0
    @weight = weight
  end

  def &(other)
    self.class.new(weight: weight * other.weight)
  end

  # See De Morgan's Laws https://en.wikipedia.org/wiki/De_Morgan%27s_laws
  def |(other)
    ~(~self & ~other)
  end

  def ~@
    self.class.new(weight: 1 - weight)
  end

  def ==(other)
    weight == other
  end

  def hash
    13 * weight
  end

  protected

  def >=(other)
    weight >= other.weight
  end
end