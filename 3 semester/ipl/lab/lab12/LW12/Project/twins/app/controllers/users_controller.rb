class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST http://127.0.0.1:3000/signup
  def create
    msg_text = ''
    msg_status = :success

    email = params[:user][:email]
    password = params[:user][:password]
    password_confirmation = params[:user][:password_confirmation]
    puts password

    @user = User.new(user_params)

    respond_to do |format|

      if @user
        if User.find_by_email(email)
          msg_text = 'Пользователь уже зарегестрирован!'
          msg_status = :danger
        elsif password != password_confirmation
          msg_text = 'Пароль для подтверждения введен неверно'
          msg_status = :danger
        elsif !email.match?('[a-z0-9]+[_a-z0-9\.-]*[a-z0-9]+@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})')
          msg_text = 'Введите почту корректно'
          msg_status = :danger
        end

        if msg_status == :success and @user.save
          sign_in @user
          msg_text = 'Спасибо за регистрацию'
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
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
