class CalcController < ApplicationController
  def index
  end

  def view
    from, to, step = params[:from].to_f, params[:to].to_f, params[:step].to_f
    if res = CalcResult.find_by_from_and_to_and_step( from, to, step )
      @result = ActiveSupport::JSON::decode( res.result )
    else
      @result = from.step(to, step).collect{ |x| [x, Math.sin(x)] }
      res = CalcResult.create :from => from, :to => to, :step => step,
                              :result => ActiveSupport::JSON::encode( @result )
      res.save#произвести изменения, из оперативной в бд
    end
    render xml: @result
    pp 'render', @result
  end
  def results
    @result = CalcResult.all
    render xml: @result
    pp 'render', @result
  end
end
