# frozen_string_literal: true

def calc(aaa, bbb)
  (Math.sin(aaa.to_f) - bbb.to_f) / (bbb.to_f.abs + Math.cos(bbb.to_f * bbb.to_f))
end
