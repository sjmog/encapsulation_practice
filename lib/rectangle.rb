require_relative './comparisons'
# Understands a four-sided polygon with sides at right angles
class Rectangle
  include Comparisons

  def initialize(length, width)
    raise "Dimension cannot be negative" unless length >= 0 && width >= 0 
    @length, @width = length, width
  end

  def self.square(side)
    new(side, side)
  end
  
  def area
    @length * @width
  end

  def perimeter
    2 * (@length + @width)
  end

  def square?
    @length == @width
  end

  protected

  def >=(other)
    area >= other.area
  end
end