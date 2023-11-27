class ChislaApiController < ApplicationController
  def view
    if params[:str]
      begin
        res = params[:str].scan(/-?\d+(?:\.\d+)?/).map(&:to_i)
        pp 'Изнач массив', res
        raise StandardError if res.length < 10
        #pp 'RES:', res, params[:str]
        @result = create(res)
      rescue StandardError
        @result = [{}, 'Something is wrong']
      end
    else
      @result = [{}, 'Unknown!']
    end
  end

  def create(res)
    max = 0
    all = []
    solution = ''
    i = 0
    loop do
      posl, len, i = create_posl(i, res)
      pp 'Каждая последовательность', posl
      all << posl.join(' ')
      if len > max
        max = len
        solution = posl.join(' ')
      end
      break if i >= res.length
    end
    pp 'До формирования',all
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
    pp 'вывод create', result
    [solution, create_table(result)]
  end

  def create_table(result)
    rows = ''
    result.each do |init, all, sol|
      rows += "<cd><former>#{init}</former><every>#{all}</every><plus>#{sol}</plus></cd>"
    end
    @table = "<catalog>#{rows}</catalog>"
    #@table = "<table border='1' class=\"table\"><tbody>#{rows}</tbody></table>"
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

