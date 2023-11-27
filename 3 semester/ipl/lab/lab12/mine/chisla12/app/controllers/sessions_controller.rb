class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

  def new
  end

  def create
    msg_text = ''
    msg_status = :success

    email = params[:session][:email]
    password = params[:session][:password]

    puts password

    respond_to do |format|
      user = User.find_by(email: email.downcase)

      if !user
        msg_text = 'Пользователя не существует'
        msg_status = :danger
      elsif user!=User.authenticate(params[:session][:email],params[:session][:password])
        msg_text = 'Неверный пароль'
        msg_status = :danger
      end

      if msg_status == :success
        sign_in user
        msg_text = 'Вы успешно вошли'
        flash[msg_status] = msg_text
        format.html { redirect_to input_path }
        format.json { render :show, status: :created, location: input_path }
      else
        flash.now[msg_status] = msg_text
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    #user = User.authenticate(params[:session][:email],params[:session][:password])
  end
  #убрать пользователя из сессии
  def destroy
    sign_out
    redirect_to root_url
  end
end
