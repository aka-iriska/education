# frozen_string_literal: true

require 'test/unit'
require './main2'

#test
class TestPal < Test::Unit::TestCase
  def test_pal
    assert_equal(true, prov('gretypyterg'))
    assert_equal(false, prov('idfdsfbk'))
    assert_equal(true, prov('typpyt'))
  end
end
