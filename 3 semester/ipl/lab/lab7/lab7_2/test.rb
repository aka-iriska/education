# frozen_string_literal: true

require 'test/unit'
require './main'

# test
class TestMinMax < Test::Unit::TestCase
  def test1
    pr = Primoug.new(2.5, 10)
    assert_equal('нет', pr.square)
    par = Paral.new(3, 3, 3)
    assert_equal('Куб', par.cube)
    assert_equal par.class.superclass, Primoug
  end
end
