# frozen_string_literal: true

require 'minitest/autorun'
require './main'

class TestCalc < MiniTest::Test
  def test_calc
    assert_in_delta(-0.925, calc(10, 5), 0.01)
    assert_in_delta(-1.225, calc(-3.5, 2), 0.01)
    assert_in_delta(0.574, calc(11, -1.5), 0.01)
  end
end
