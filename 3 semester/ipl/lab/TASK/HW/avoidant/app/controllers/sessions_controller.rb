class SessionsController < ApplicationController
  def new; end

  def create
    msg_text = ''
    msg_status = :success

    email = params[:session][:email]
    password = params[:session][:password]

    puts password

    respond_to do |format|
      user = User.find_by(email: email.downcase)

      if !user
        msg_text = I18n.translate(:user_does_not_exist)
        msg_status = :danger
      elsif !user.authenticate(password)
        msg_text = I18n.translate(:wrong_pwd)
        msg_status = :danger
      end

      if msg_status == :success
        sign_in user
        msg_text = I18n.translate(:successfully_logged)
        flash[msg_status] = msg_text
        format.html { redirect_to home_path }
        format.json { render :show, status: :created, location: home_path }
      else
        if msg_text.empty?
          msg_text = "#{I18n.translate(:incorrect_data)} - #{@user.errors.objects.first.full_message}"
          msg_status = :danger
        end

        flash.now[msg_status] = msg_text
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    pp 'Logout'
    sign_out
    redirect_to signin_url
  end
end
