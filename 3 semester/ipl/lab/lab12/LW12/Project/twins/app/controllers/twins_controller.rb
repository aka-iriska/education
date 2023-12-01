# frozen_string_literal: true
class TwinsController < ApplicationController
  def input
    unless signed_in?
      redirect_to signin_path
    end
  end

  def view
    unless signed_in?
      redirect_to signin_path
    end

    n = params[:n].to_i
    @result = twins(n)
  end

  def is_prime(num)
    return false if num <= 1
    Math.sqrt(num).to_i.downto(2).each {|i| return false if num % i == 0}
    true
  end

  def twins(n)
    pairs = {}
    (n..2 * n).each do |first|
      (first..2 * n).each do |second|
        if second - first == 2 and is_prime(first) and is_prime(second)
          pairs[first] = second
        end
      end
    end

    [pairs, to_table(pairs)]

  end

  def to_table(pairs = @result, table_class = 'table table-striped')
    @table = 'Unknown!'

    unless pairs.empty?
      rows = ''
      pairs.each do |key, value|
        rows += "<tr><td>#{key}</td><td>#{value}</td></tr>"
      end
      @table = "<table class=\"#{table_class}\"><tbody>#{rows}</tbody></table>"
    end

    @table
  end
end
