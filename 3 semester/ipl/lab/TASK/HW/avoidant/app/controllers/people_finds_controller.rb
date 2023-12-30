class PeopleFindsController < ApplicationController
  before_action :set_find, only: %i[ show edit update destroy ]

  # GET /finds or /finds.json
  def index
    @finds = PeopleFind.all
  end

  # GET /people_finds/1 or /people_finds/1.json
  def show
  end

  # GET /people_finds/new
  def new
    @find = PeopleFind.new
  end

  # GET /people_finds/1/edit
  def edit
  end

  def update_params_args
    # Выставляем nil для значений и верный строковые значения

    if params[:find].key?('wrinkles') && params[:find][:wrinkles] == 'on'
      params[:find][:wrinkles] = 'есть'
    else
      params[:find][:wrinkles] = 'нет'
    end

    if params[:find].key?('facial_hair') && params[:find][:facial_hair] == 'on'
      params[:find][:facial_hair] = 'есть'
    else
      params[:find][:facial_hair] = 'нет'
    end

    if params[:find][:race] == ''
      params[:find][:race] = nil
    end

    if params[:find][:body_type] == ''
      params[:find][:body_type] = nil
    end

    if params[:find][:voice] == ''
      params[:find][:voice] = nil
    end

    if params[:find][:ears] == ''
      params[:find][:ears] = nil
    end

    if params[:find][:forehead] == ''
      params[:find][:forehead] = nil
    end

    unless params[:find][:hair_checkbox]
      params[:find][:hair_color] = nil
    end

    params.delete(:hair_checkbox)

    pp 'params update'
  end

  # POST /people_finds or /people_finds.json
  def create
    unless signed_in?
      pp 'You not sign in'

      msg_text = I18n.t(:signin_or_signup)
      msg_status = :warning
      flash[msg_status] = msg_text

      respond_to do |format|
        format.html { redirect_to signin_path }
      end

      return
    end

    update_params_args

    params[:find][:users_id] = current_user.id

    puts 'create_find_controller_params', params

    @find = PeopleFind.new(find_params)

    respond_to do |format|
      if @find.save
        msg_text = I18n.t(:search_request_created)
        msg_status = :success
        flash[msg_status] = msg_text

        format.html { redirect_to create_post_path }
        format.json { render :show, status: :created, location: @find }
      else
        msg_text = I18n.t(:error)
        msg_status = :danger
        flash[msg_status] = msg_text

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @find.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people_finds/1 or /people_finds/1.json
  def update
    pp 'Update find', @find.id, params
    update_params_args
    pp params

    respond_to do |format|
      flash[:success] = I18n.t(:post_updated)

      if @find.update(find_params)
        format.html { redirect_to home_url }
        format.json { render :show, status: :ok, location: @find }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @find.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people_finds/1 or /people_finds/1.json
  def destroy
    pp 'Delete...'
    @find = PeopleFind.find_by_id(params[:id])
    @find.destroy!
    pp 'Deleted'

    respond_to do |format|
      flash[:success] = I18n.t(:post_removed)
      format.html { redirect_to home_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_find
    @find = PeopleFind.find_by_id(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def find_params
    params.require(:find).permit(:searcher_email, :searcher_name, :users_id, :address, :gender, :age,
                                 :body_type, :height, :race, :facial_hair, :voice, :hair_color, :ears, :wrinkles,
                                 :forehead)
  end
end
