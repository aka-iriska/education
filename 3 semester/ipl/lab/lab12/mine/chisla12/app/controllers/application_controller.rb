class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :authenticate, :except => [:signup, :signin, :new, :create]
  private
  #если идентификатор пользователя есть (session[:current_user_id]), то записываем в _current_user
  #если его нет, то сделаем выборку из базы (User.find_by id(...))
  def current_user
    @_current_user ||= session[:current_user_id] &&
      User.find_by_id(session[:current_user_id])
  end
  def authenticate
    unless current_user
      redirect_to signin_path
    end
  end
end
