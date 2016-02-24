require_relative './comparisons'
# Understands a specific measurement
class IntervalQuantity
  include Comparisons
  EPSILON = 0.000001

  attr_reader :amount, :unit
  protected :amount, :unit

  def initialize(amount, unit)
    @amount, @unit = amount, unit
  end

  def ==(other)
    return false unless other.is_a?(IntervalQuantity) && compatible?(other)
    (self.amount - converted_amount(other)).abs < EPSILON
  end

  def hash
    13 * @amount.hash + unit.hash
  end

  protected

  def >=(other)
    amount >= converted_amount(other)
  end

  private

  def converted_amount(other)
    self.unit.converted_amount_from(other.amount, other.unit)
  end

  def compatible?(other)
    self.unit.compatible?(other.unit)
  end
end