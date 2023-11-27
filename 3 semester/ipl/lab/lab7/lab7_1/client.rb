# frozen_string_literal: true

require './main'

puts('Введите количество чисел в файле F, кратное 40: ')
f = false
loop do
  count = gets.chomp
  if (count.to_i.to_s == count) && (count.to_i % 40).zero?
    f = true
    count = count.to_i
    puts('Файл F:')
    fill_file_f(count)
    puts('Файл P:')
    fill_file_p(5)
    fill_file_p(20)
  else
    puts('Введено некорректное значение. Попробуйте ещё раз')
  end
  break if f == true
end
