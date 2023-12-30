# frozen_string_literal: true

class ChislaController < ApplicationController
  def input
    if params[:str]
      puts params
      res = params[:str].split.map(&:to_i)
      @result = create(res)
      #{ type: @result[1].class.to_s, value: @result[1]}
      respond_to do |format|
        format.html
        format.json do
          render json:
                   { type: @result[1].class.to_s, value: @result[1] }
        end
      end
      else @result =['','']
    end
  end

  def create(res)
    max = 0
    all = []
    solution = ''
    i = 0
    loop do
      len = 0
      posl = [res[i]]
      i += 1
      while res[i] > res[i - 1]
        len += 1
        posl << res[i]
        break unless i + 1 < res.length

        i += 1

      end
      all << posl.join(' ')
      if len > max
        max = len
        solution = posl.join(' ')
      end
      break if i + 1 == res.length
    end
    result = []
    all.length.times do |j|
      str = if solution == all[j]
              '+'
            else
              ' '
            end
      result << if j.zero?
                  [res.join(' '), all[j], str]
                else
                  [' ', all[j], str]
                end
    end
    [result, create_table(result)]
    # @final = solution
    # @solution = result
  end

  def create_table(result)
    rows = ''
    result.each do |init, all, sol|
      rows += "<tr><td>#{init}</td><td>#{all}</td><td>#{sol}</td></tr>"
    end
    @table = "<table class=\"table\"><tbody>#{rows}</tbody></table>"
  end
end