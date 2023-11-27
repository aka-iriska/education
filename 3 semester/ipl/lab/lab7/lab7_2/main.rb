# frozen_string_literal: true

# class Parent
class Primoug
  attr_accessor :a, :b

  def initialize(first, second)
    @a = first
    @b = second
  end

  def print
    puts("Сторона 1: #{@a}")
    puts("Сторона 2: #{@b}")
  end

  def square
    if @a == @b
      'да'
    else
      'нет'
    end
  end
end

# class Child
class Paral < Primoug
  attr_accessor :h

  def initialize(first, second, third)
    super(first, second)
    @h = third
  end

  def print
    Primoug.instance_method(:print).bind(self).call
    puts("Сторона 3: #{@h}")
  end

  def cube
    if !(@a == @b && @b == @h)
      'Прямоугольный параллелепипед'
    else
      'Куб'
    end
  end
end
