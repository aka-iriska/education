# frozen_string_literal: true

require './main'

puts('Введите первую сторону прямоугольника')
a = gets.chomp.to_f
puts('Введите вторую сторону прямоугольника')
b = gets.chomp.to_f
pr = Primoug.new(a, b)
puts('Квадрат или нет: ')
puts(pr.square)
puts('Введите третью сторону параллелепипеда')
c = gets.chomp.to_f
par = Paral.new(a, b, c)
puts('Куб или нет: ')
puts(par.cube)
