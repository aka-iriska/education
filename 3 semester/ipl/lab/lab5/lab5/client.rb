# frozen_string_literal: true

require './main'
puts('Введите a')
a = gets.chomp
puts('Введите b')
b = gets.chomp
puts('Y: ')
puts(calc(a, b))
