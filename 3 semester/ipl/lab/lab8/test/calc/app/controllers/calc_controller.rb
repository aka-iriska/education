class CalcController < ApplicationController
  def input
  end

  def view
	v1, v2 = params[:v1].to_i,
v2 = params[:v2].to_i
@result = case params[:op]
when "+" then v1 + v2;
when "-" then v1 - v2;
when "*" then v1 * v2;
when "/" then v1 / v2;
else "Unknown!"
end
  end
end
