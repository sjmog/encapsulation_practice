# Copyright 2016 by Fred George. May be copied with this notice, but not used in classroom training.

require_relative './interval_quantity'

# Understands a specific measurement
class RatioQuantity < IntervalQuantity
  def -@
    RatioQuantity.new(-@amount, @unit)
  end

  def +(other)
    RatioQuantity.new(self.amount + converted_amount(other), self.unit)
  end

  def -(other)
    self + -other
  end
end