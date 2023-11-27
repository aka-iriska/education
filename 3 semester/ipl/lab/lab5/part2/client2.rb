# frozen_string_literal: true

require './main2'
puts('Введите строку')
s = gets.chomp
if prov(s) == true
  puts('Является палиндромом')
else
  puts('Не является палиндромом')
end
