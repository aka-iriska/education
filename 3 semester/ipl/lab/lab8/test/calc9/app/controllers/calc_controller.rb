class CalcController < ApplicationController
  def input
    render layout: false#запретить подставлять внешнее обрамление
  end

  def view
    v1 = params[:v1].to_i
    v2 = params[:v2].to_i
    @result = case params[:op]
              when "+" then v1 + v2;
              when "-" then v1 - v2;
              when "*" then v1 * v2;
              when "/" then v1 / v2;
              else "Unknown!"
              end
    respond_to do |format|
      format.html#обрабатывать форматы html
      #будет исп представление с шаблоном view.html.erb
      format.json do #обрабатывать форматы json
        #будет явно вызван метод render
        render json:
                 {type: @result.class.to_s, value: @result}
      end
    end
  end
end
