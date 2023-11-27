# frozen_string_literal: true

def i_am_matematic(eps, rad)
  list = Enumerator.new do |yielder|
    number = 3
    sum = counting(number + 1, rad)
    prev = counting(number, rad)
    iter = 0
    loop do
      yielder.yield sum, prev, iter
      prev = sum
      number += 1
      sum = counting(number + 1, rad)
      iter += 1
    end
    puts(iter)
  end
  a = list.find { |sum, prev| (prev - sum).abs < eps }.each
  a.next # число которое уже не подходит по условию
  summa = a.next.round(4).to_f
  iter = a.next
  puts(iter)
  summa
end

# number - количество сторон
def counting(number, rad)
  0.5 * rad * rad * number * Math.sin(2 * Math::PI / number)
end
