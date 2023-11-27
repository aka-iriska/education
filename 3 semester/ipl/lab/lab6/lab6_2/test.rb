# frozen_string_literal: true

require 'test/unit'
require './main'

# test
class TestPal < Test::Unit::TestCase
  def test_pal
    assert_in_delta(Math::PI * 5 * 5, i_am_matematic(0.001, 5), 0.1)
    assert_in_delta(Math::PI * 3 * 3, i_am_matematic(0.0001, 3), 0.1)
    assert_in_delta(Math::PI * 2 * 2, i_am_matematic(0.001, 2), 0.1)
  end
end
