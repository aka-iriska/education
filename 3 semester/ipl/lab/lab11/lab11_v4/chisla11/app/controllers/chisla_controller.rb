require 'json'

class ChislaController < ApplicationController
  def input
  end

  def view
    if params[:str]
      begin
        res = params[:str].scan(/-?\d+(?:\.\d+)?/).map(&:to_i)
        raise StandardError if res.length < 10
        @result = check(res)
      rescue StandardError
        @result = [{}, 'Что-то пошло не так', 'error']
      end
    else
      @result = [{}, 'Unknown!', 'error']
    end
  end

  def check(res)
    res_bs = ChislaResult.find_by_string(res.join(' '))

    # поиск предыдущего результата вычислений
    if res_bs
      pp 'Начали доставать из БД...'
      pp 'ActiveSupport', ActiveSupport::JSON::decode(res_bs.result)
      pp 'JSON', JSON.parse(res_bs.my_table)
      returning = [ActiveSupport::JSON::decode(res_bs.result), JSON.parse(res_bs.my_table), true]
      pp 'Результат уже посчитан'
    else
      # сохранение данных в бд:
      returning = create(res) + [false]
      pp 'Результат просчитан впервые'
      res_bs = ChislaResult.create :string => res.join(' '), :result => ActiveSupport::JSON::encode(returning[0]), :my_table => returning[1].to_json
      res_bs.save
      print 'Запись добалена в БД ', res_bs, "\n"
    end

    sol = returning[0]
    everything = returning[1]
    [sol, create_table(everything), returning[2]]
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
    [solution, result]
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

