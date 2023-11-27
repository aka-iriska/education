require 'nokogiri'

class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  XSLT_TRANSFORM = "#{Rails.root}/public/some_transformer.xslt".freeze # Путь до xslt файла
  # GET /users or /users.json
  def index
    @users = User.all
    @user_name = current_user ? current_user.name : "unknown"
  end
  # для вывод БД в XML

  # Добавить действие в контроллер, позволяющее определить, что хранится в БД через сериализацию в XML.
  # http://127.0.0.1:3000/show_all.xml
  def show_all
    respond_to do |format|
      results = User.all
      rows = ''
      results.each do |record|
        rows += "<cd><name>#{record.name}</name><email>#{record.email}</email><pass>#{record.password}</pass></cd>"
      end
      responce = "<catalog>#{rows}</catalog>"
      format.xml { render xml: xslt_transform(responce).to_xml }
    end
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

  # POST /users or /users.json
  def create
    msg_text = ''
    msg_status = :success

    email = params[:user][:email]
    @user = User.new(user_params)

    respond_to do |format|
      if @user
        if User.find_by_email(email)
          msg_text = 'Пользователь уже зарегестрирован!'
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
    params.require(:user).permit(:name, :email, :password)
  end



  def xslt_transform(data, transform: XSLT_TRANSFORM)
    # Функция преобразования
    pp 'checkpoint2'
    print data, transform, "\n"
    doc = Nokogiri::XML(data)
    xslt = Nokogiri::XSLT(File.read(transform))
    xslt.transform(doc)
  end

end
