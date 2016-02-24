require 'minitest/autorun'
require_relative '../lib/rectangle'

# Confirms behavior of Rectangle
class RectangleTest < Minitest::Test
  LARGE_SQUARE = Rectangle.square(4)
  SMALL_SQUARE = Rectangle.square(2)

  LARGE_RECTANGLE = Rectangle.new(4, 6)
  SMALL_RECTANGLE = Rectangle.new(2, 3)

  def test_area
    assert_equal(24, LARGE_RECTANGLE.area)
  end

  def test_perimeter
    assert_equal(20, LARGE_RECTANGLE.perimeter)
  end

  def test_invalid_rectangle
    assert_raises(Exception) { Rectangle.new(-1, 2) }
  end

  def test_square_creation
    assert_equal(9, Rectangle.square(3).area)
  end

  def test_squareness
    assert(Rectangle.square(3).square?)
    assert(Rectangle.new(4, 4).square?)
  end

  def test_largest
    assert_equal(LARGE_SQUARE.max([SMALL_SQUARE]), LARGE_SQUARE)
    assert_equal(LARGE_RECTANGLE.max([SMALL_RECTANGLE]), LARGE_RECTANGLE)
    assert_equal(LARGE_RECTANGLE.max([LARGE_RECTANGLE]), LARGE_RECTANGLE)
  end
end
