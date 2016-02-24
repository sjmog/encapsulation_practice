require 'minitest/autorun'
require_relative '../lib/unit'

# Confirms behavior of Quantity
class QuantityTest < Minitest::Test

  def test_equality_of_like_units
    assert_equal(6.teaspoons, 6.teaspoons)
    refute_equal(6.teaspoons, 4.teaspoons)
    refute_equal(6.teaspoons, Object.new)
  end

  def test_equality_of_different_units
    assert_equal(3.cups, 24.ounces)
    assert_equal(24.ounces, 0.75.quarts)
    refute_equal(6.teaspoons, 6.cups)
    refute_equal(6.teaspoons, nil)
    assert_equal(0.5.yards, 18.inches)
  end

  def test_hash
    assert_equal(24.ounces.hash, 24.ounces.hash)
  end

  def test_arithmetic
    assert_equal(-24.ounces, 3.cups - 1.5.quarts)
    assert_equal(-24.ounces, -(24.ounces))
    assert_equal(15.inches, 1.yards - 1.75.feet)
  end

  def test_inequality_of_different_metrics
    refute_equal(1.inches, 1.teaspoons)
    refute_equal(1.cups, 4.feet)
    refute_equal(1.celcius, 1.teaspoons)
  end

  def test_invalid_arithmetic
    assert_raises(Exception) { 2.feet + 2.ounces }
    assert_raises(Exception) { 2.feet + 2.fahrenheit }
  end

  def test_temperature
    assert_equal(-40.celcius, -40.fahrenheit)
    assert_equal(-40.fahrenheit, -40.celcius)
    assert_equal(0.celcius, 32.fahrenheit)
    assert_equal(32.fahrenheit, 0.celcius)
    assert_equal(10.celcius, 50.fahrenheit)
    assert_equal(50.fahrenheit, 10.celcius)
    assert_equal(100.celcius, 212.fahrenheit)
    assert_equal(212.fahrenheit, 100.celcius)
  end

  def test_maxitudinalisms
    assert_equal(100.celcius.max([101.celcius]), 101.celcius)
    assert_equal(0.celcius.max(50.fahrenheit, -8.celcius), 50.fahrenheit)
    assert_equal(0.celcius.max(50.fahrenheit), 10.celcius)
    assert_equal(6.teaspoons.max([2.teaspoons, 4.quarts]), 4.quarts)
    assert_raises(Exception) { 6.teaspoons.max(4.celcius) }
  end
end