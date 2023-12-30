class AvoidantController < ApplicationController
  skip_before_action :verify_authenticity_token # Fix Completed 422 Unprocessable Entity
  @@current_users = nil

  def index; end

  def update_people
    puts 'Update people list', params
    filter
    is_page_last
    pp 'Filtered @@all_users length'

    respond_to do |format|
      format.js
    end
  end

  def is_page_last
    # Проверяем, нет ли больше элементов БД для демонстрации

    if params[:req_from] == 'people'
      pp @all_users.last(1)[0], @@current_users.last(1)[0]
      @last_page = @all_users.last(1)[0] == @@current_users.last(1)[0]
    elsif params[:req_from] == 'home'
      pp @all_searched_users.last(1)[0], @@current_users.last(1)[0]
      @last_page = @all_searched_users.last(1)[0] == @@current_users.last(1)[0]
    end

    pp '@last_page', @last_page

  end

  def _load_more
    # Загрузить следующие 10 элементов

    unless @@current_users
      if params[:req_from] == 'people'
        take_first_10('people')
      elsif params[:req_from] == 'home'
        take_first_10('home')
      end

    end

    pp 'load_more elements', @@current_users.length
    session[:element_per_page] = session[:element_per_page] + 10

    if params[:req_from] == 'people'
      @all_users = @@current_users.limit(session[:element_per_page])
    elsif params[:req_from] == 'home'
      @all_searched_users = @@current_users.limit(session[:element_per_page])
    end

    is_page_last
  end

  def load_more
    _load_more
    pp 'loaded'

    respond_to do |format|
      format.js { render "load_more" }
    end
  end

  def filter
    pp 'filter...', params
    filter_params = {}

    filter_name = :filter

    if params.key?(filter_name)
      pp 'filter_params', params

      # Морщины
      if params[filter_name].key?('wrinkles')
        if params[filter_name][:wrinkles] == 'on'
          params[filter_name][:wrinkles] = 'есть'
          pp 'есть'
        else
          params[filter_name][:wrinkles] = 'нет'
          pp 'нет'
        end
      end

      # Растительность на лице
      if params[filter_name].key?('facial_hair')
        if params[filter_name][:facial_hair] == 'on'
          params[filter_name][:facial_hair] = 'есть'
          pp 'есть'
        else
          params[filter_name][:facial_hair] = 'нет'
          pp 'нет'
        end
      end

      unless params[filter_name].key?(:hair_checkbox)
        params[filter_name][:hair_color] = nil
        pp 'No hair color'
      end

      params[filter_name].each do |param, value|
        if !value.nil? && value != '' && param != 'hair_checkbox'
          filter_params[param] = value.downcase
        end
      end

      pp 'filter_params', filter_params
      puts 'Filter...'

      @@current_users = if !filter_params.empty?
                          PeopleFind.where(filter_params)
                        else
                          PeopleFind.all
                        end

      @all_users = @@current_users.limit(10)
    else
      pp 'No filter'
    end
  end

  def take_first_10(page = 'people')
    session[:element_per_page] = 10

    unless params[:req_from]
      # При первом заходе может не быть такого параметра
      params[:req_from] = page
    end

    if page == 'people'
      @@current_users = PeopleFind.all
      @all_users = @@current_users.limit(10)
    elsif page == 'home'
      @@current_users =  PeopleFind.where(users_id: current_user.id)
      @all_searched_users = @@current_users.limit(10)
    end

  end

  def reset_filter
    pp 'reset_filter'
    take_first_10

    respond_to do |format|
      format.js
    end
  end

  def people
    pp 'people: ', params

    if params[:operation] == 'filter'
      pp 'people filter_request: ', params
      @filter_request = params[:filter_request]
    else
      take_first_10
    end

    respond_to do |format|
      format.html
      format.json do
        pp 'RENDER JSON'
        render json:
                 { type: @filter_request.class.to_s, value: @filter_request }
      end
    end
  end

  def create
    puts 'avoidant_params', params
  end

  def home
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

    take_first_10('home')
    is_page_last
  end
end
