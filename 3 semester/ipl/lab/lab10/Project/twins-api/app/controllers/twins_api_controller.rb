class TwinsApiController < ApplicationController

  def view
    n = params[:n].to_i

    # Возвращаем результат
    @result = twins(n)
  end

  def is_prime(num)
    return false if num <= 1

    Math.sqrt(num).to_i.downto(2).each { |i| return false if (num % i).zero? }
    true
  end

  def twins(n)
    pairs = {}
    (n..2 * n).each do |first|
      (first..2 * n).each do |second|
        if (second - first == 2) && is_prime(first) && is_prime(second)
          pairs[first] = second
        end
      end
    end

    [pairs, to_table(pairs)]
  end

  def to_table(pairs = @result)
    # Создание xml таблицы

    @table = 'Unknown!'

    unless pairs.empty?
      rows = ''
      pairs.each do |key, value|
        rows += "<cd><id>#{key}</id><item>#{value}</item></cd>"
      end
      @table = "<catalog>#{rows}</catalog>"
    end

    puts @table
    @table
  end
end
