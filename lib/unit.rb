# Copyright 2016 by Fred George. May be copied with this notice, but not used in classroom training.

require_relative './ratio_quantity'

# Understands a specific metric
class Unit
  attr_reader :base_unit_count, :offset, :unit_type
  protected :base_unit_count, :offset, :unit_type

  def initialize(plural_label, relative_unit_count, relative_unit, offset = 0)
    @offset = offset
    @base_unit_count = relative_unit_count * relative_unit.base_unit_count.to_f
    @unit_type = relative_unit.unit_type
    create_numeric_builder(plural_label, @unit_type)
  end

  def converted_amount_from(other_amount, other_unit)
    raise "Incompatible unit types" unless self.compatible?(other_unit)
    (other_amount - other_unit.offset) * 
        other_unit.base_unit_count / self.base_unit_count + self.offset
  end

  def compatible?(other)
    self.unit_type == other.unit_type
  end

  class UnitType
    def initialize(quantity_class)
      @quantity_class = quantity_class
    end
    def quantity(amount, unit); @quantity_class.new(amount, unit); end
    def base_unit_count; 1.0; end
    def unit_type; self; end
  end

  private

    def create_numeric_builder(plural_label, unit_type)
      unit = self
      Numeric.class_eval do
        define_method plural_label.to_s do
          unit_type.quantity(self, unit)
        end
      end
    end

  teaspoon = new(:teaspoons, 1, UnitType.new(RatioQuantity))
  tablespoon = new(:tablespoons, 3, teaspoon)
  ounce = new(:ounces, 2, tablespoon)
  cup = new(:cups, 8, ounce)
  pint = new(:pints, 2, cup)
  quart = new(:quarts, 2, pint)
  gallon = new(:gallons, 4, quart)

  inch = new(:inches, 1, UnitType.new(RatioQuantity))
  foot = new(:feet, 12, inch)
  yard = new(:yards, 3, foot)
  mile = new(:miles, 1780, yard)

  celcius = new(:celcius, 1, UnitType.new(IntervalQuantity))
  fahrenheit = new(:fahrenheit, 5/9.0, celcius, 32)

  private_class_method :new

end
