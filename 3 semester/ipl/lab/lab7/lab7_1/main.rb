# frozen_string_literal: true

def fill_file_f(count)
  time = count / 10
  file_f = File.open('f.txt', 'w')
  array = []
  iter = 0
  time.times do
    if iter.even?
      10.times { array << Random.rand(1..100) }
    else
      10.times { array << Random.rand(-100..-1) }
    end
    iter += 1
  end
  array.length.times { |i| file_f.write("#{array[i]} ") }
  file_f.close
  printing(file_f.path)
end

def fill_file_p(number)
  array = File.readlines('f.txt')[0].to_s.split.map(&:to_i)
  array_of_pol = []
  array_of_otr = []
  # разделяем положительные и отрицательные элементы
  array.length.times do |i|
    if (array[i]).positive?
      array_of_pol << array[i]
    else
      array_of_otr << array[i]
    end
  end
  # записываем нужный порядок в новый массив
  new_array = []
  iterpol = 0
  iterotr = 0
  array.length.times do
    number.times do
      new_array << array_of_pol[iterpol]
      iterpol += 1
    end
    number.times do
      new_array << array_of_otr[iterotr]
      iterotr += 1
    end
  end
  # переносим из нового массива с правильным порядком в файл
  file_p = File.open('p.txt', 'w')
  new_array.length.times { |i| file_p.write("#{new_array[i]} ") }
  file_p.close
  printing(file_p.path)
end

def printing(file_name)
  file = File.open(file_name, 'r')
  puts file.readlines
  file.close
end
