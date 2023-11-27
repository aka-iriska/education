# frozen_string_literal: true

def shifr(str, number)
  abc = ('a'..'z').zip(1..26).to_h
  strmap = str.split
  id = 0 # индекс слова в строке
  strmap.each do |slovo|
    newstr = ''
    slovo.each_char do |bukva|
      newbukva = zamenab(abc, bukva, number)
      newstr += newbukva
    end
    strmap[id] = newstr
    id += 1
  end
  strmap.join(' ')
end

def zamenab(abc, bukva, number)
  n = abc[bukva].to_i
  n -= 26 if n + number > 26
  n += 26 if n + number < 1
  abc.key(n + number)
end
