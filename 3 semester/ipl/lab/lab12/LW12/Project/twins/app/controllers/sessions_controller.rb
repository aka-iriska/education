class SessionsController < ApplicationController
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
      elsif !user.authenticate(password)
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
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
