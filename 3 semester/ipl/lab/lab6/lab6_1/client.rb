# frozen_string_literal: true

require './main'
loop do
  puts('Введите радиус окружности: ')
  r = gets.chomp.to_f
  puts('Введите точность вычисления: ')
  puts('1) 0.001')
  puts('2) 0.0001')
  f = false
  n = 0
  loop do
    case gets.chomp.to_i
    when 1
      n = 0.001
      f = true
    when 2
      n = 0.0001
      f = true
    else
      puts('Вы ввели некорректное значение. Попробуйте снова')
    end
    break if f == true
  end
  puts('Число итераций: ')
  puts(i_am_matematic(n, r))
  break if gets.chomp == 'end'
end

=begin
Введите радиус окружности:
0.1
Введите точность вычисления:
1) 0.001
2) 0.0001
1
Число итераций:
4
0.027364101886381047
0.028284271247461905
0.028925442435894275
0.0274
=end