# frozen_string_literal: true

def i_am_matematic(eps, rad)
  # s=1/2 R**2 n sin(2pi/n)
  n = 3
  iter = 0
  loop do
    n += 1
    iter += 1
    break if counting(n, rad) - counting(n - 1, rad) < eps
  end
  puts(iter - 1) # потому что последняя проверка не работает и просих выход из цикла
  counting(n - 1, rad).round(4).to_f
end

# number - количество сторон
def counting(number, rad)
  0.5 * rad * rad * number * Math.sin(2 * Math::PI / number)
end
