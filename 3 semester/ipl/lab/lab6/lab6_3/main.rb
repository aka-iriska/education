# frozen_string_literal: true

def minmax(stt, enn, &block)
  eps = 0.01
  stt.to_f
  enn.to_f
  massive = {}
  steps = ((enn - stt) / eps).truncate + 1 # количество шагов
  steps.times do
    massive[stt.round(3)] = block.call(stt.round(3)).round(4).to_f
    stt += eps
  end
  extrem = []
  extrem << massive.min_by(&:last).first
  extrem << massive.max_by(&:last).first
  extrem
end
