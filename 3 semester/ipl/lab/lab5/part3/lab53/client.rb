# frozen_string_literal: true

require './main'
puts('Введите n - на сколько букв вперёд будет производиться замена')
n = gets.chomp.to_i
puts('Введите количеcтво строк')
count = gets.chomp.to_i
puts('Введите каждую из них, разделяя слова пробелами')
massive = []
massive_former = []
count.times do
  str = gets.chomp
  str.tr!('0-9', '')
  str.downcase!
  massive_former << str
  massive << shifr(str, n)
end
puts('Зашифрованные строки: ')
massive_former.each { |s| puts s }
puts('Раcшифрованные строки: ')
massive.each { |s| puts s }
