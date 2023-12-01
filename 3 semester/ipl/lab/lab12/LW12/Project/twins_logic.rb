# frozen_string_literal: true

def twins(n)
  pairs = {}
  (n..2 * n).each do |first|
    (first..2 * n).each do |second|
      pairs[first] = second if second - first == 2
    end
  end

  pairs.empty? ? 'No pairs' : pairs

end

puts twins(10)
puts twins(1)
