# frozen_string_literal: true

require 'test/unit'
require './main'

def random_str(len = 10, character_set = ['a'..'z'])
  characters = character_set.map(&:to_a).flatten
  characters_len = characters.length
  (0...len).map { characters[rand(characters_len)] }.join
end

def rand_words(num, len = 10, character_set = ['a'..'z'])
  str = ''
  num.times do |_i|
    str += "#{random_str(len, character_set)} "
  end
  str.strip
end

def prov(str, number)
  str_map = str.split
  newstr = ''
  str_map.each do |slovo|
    newslovo = zamena(slovo, number)
    newstr += "#{newslovo} "
  end
  newstr.chop
end

def zamena(word, number)
  abc = ('a'..'z').to_a
  new_abc = abc.zip(newabc(abc, number)).to_h
  word.chars.map { |c| new_abc.key?(c) ? new_abc[c] : c }.join
end

def newabc(abc, number)
  newabc = []
  abc.each_with_index do |_bukva, index|
    number -= 26 if index + number > 25
    newabc << (abc[index + number]).to_s
  end
  newabc
end
# str='odunxlklkn ncpjzqomab utmwfnbdjv nyfstfvfix'

# test
class TestShift < Test::Unit::TestCase
  def test_shift1
    n = 1
    str = rand_words(4)
    assert_equal(prov(str, n), shifr(str, n))
  end

  def test_shift2
    n = 10
    str = rand_words(2)
    assert_equal(prov(str, n), shifr(str, n))
  end

  def test_shift3
    n = -1
    str = rand_words(5)
    assert_equal(prov(str, n), shifr(str, n))
  end
end
