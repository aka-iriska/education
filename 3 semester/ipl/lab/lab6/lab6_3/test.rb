# frozen_string_literal: true

require 'test/unit'
require './main'

# test
class TestMinMax < Test::Unit::TestCase
  def test1
    lb = ->(x) { Math.sin(x * x - 1) }
    @res = minmax(0, 2, &lb)[1].to_f
    assert_in_delta(1.6, @res, 0.01)
  end

  def test2
    lb = ->(x) { x * x * x + x * x }
    @res = minmax(-2, 0, &lb)[1].to_f
    assert_in_delta(-0.67, @res, 0.01)
  end

  def test3
    @res = minmax(1, 3) { |x| -1 / (x * x) }[1]
    assert_in_delta(3, @res, 0.01)
  end

  def test4
    @res = minmax(0, 2) { |x| Math.cos(x * x + 3 * x - 1) }[0] # минимум
    assert_in_delta((1.0 / 2) * Math.sqrt(13 + 4 * Math::PI) - 3.0 / 2, @res, 0.01)
  end
end
