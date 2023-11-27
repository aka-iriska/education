# frozen_string_literal: true

require 'test/unit'
require './main'

# test
class TestMinMax < Test::Unit::TestCase
  def test1
    file_f = File.open('f.txt', 'w')
    file_f.write('1 2 3 4 5 6 -1 -2 -3 -4 -5 -6')
    file_f.close
    fill_file_p(3) # по 3 пол и по 3 отриц
    assert_equal([1, 2, 3, -1, -2, -3, 4, 5, 6, -4, -5, -6],
                 File.readlines('p.txt')[0].to_str.split.map(&:to_i))
    assert_equal(true, File.exist?('f.txt'))
    assert_equal(true, File.exist?('p.txt'))
  end
end
