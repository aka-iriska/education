# frozen_string_literal: true

require './main'
loop do
  puts('Выберите функцию: ')
  puts('1) y = (x-1)/(x+2)')
  puts('2) y = sin(x/2 - 1)')
  f = false
  loop do
    case gets.chomp.to_i
    when 1
      f = true
      stt = 0.0
      enn = 2.0
      puts('Вызов через блок')
      puts(minmax(stt, enn) { |x| (x - 1) / (x + 2) }) # через блок
      puts('Вызов через лямбда')
      lb = ->(x) { (x - 1) / (x + 2) } # лямбда выражение
      puts(minmax(stt, enn, &lb))
    when 2
      f = true
      stt = -1.0
      enn = 1.0
      puts('Вызов через блок')
      puts(minmax(stt, enn) { |x| Math.sin(x / 2 - 1) }) # через блок
      puts('Вызов через лямбда')
      lb = ->(x) { Math.sin(x / 2 - 1) } # лямбда выражение
      puts(minmax(stt, enn, &lb))
    else
      puts('Вы ввели некорректное значение. Попробуйте снова')
    end
    break if f == true
  end
  break if gets.chomp == 'end'
end
