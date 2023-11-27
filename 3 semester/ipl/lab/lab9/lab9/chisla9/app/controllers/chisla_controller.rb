# frozen_string_literal: true

class ChislaController < ApplicationController
  def input
    if params[:str]
      begin
      res = params[:str].scan(/-?\d+(?:\.\d+)?/).map(&:to_i)
      raise StandardError if res.length<10
      pp 'RES:', res, params[:str]
      @result = create(res)
      rescue StandardError
        @result=['', 'Что-то пошло не так']
      end
    else
      @result = ['', 'Unknown!']
    end

    respond_to do |format|
      format.html
      format.json do
        render json:
                 { type: @result.class.to_s, value: @result }
      end
    end
  end

  def create(res)
    max = 0
    all = []
    solution = ''
    i = 0
    loop do
      posl, len, i = create_posl(i, res)
      all << posl.join(' ')
      if len > max
        max = len
        solution = posl.join(' ')
      end
      break if i >= res.length
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
    [solution, create_table(result)]
  end

  def create_table(result)
    rows = "<tr><th>#{'Изначальный'}</th><th>#{'Все возможные'}</th><th>#{'Самая длинная'}</th></tr>"
    result.each do |init, all, sol|
      rows += "<tr><td>#{init}</td><td>#{all}</td><td>#{sol}</td></tr>"
    end
    @table = "<table border='1' class=\"table\"><tbody>#{rows}</tbody></table>"
  end
  def create_posl(i, res)
    len = 0
    posl = []
    loop do
      len += 1
      posl << res[i]
      break if i + 1 == res.length
      break if (res[i+1] <= res[i])
      i += 1
    end
    i+=1
    [posl, len, i]
  end
end