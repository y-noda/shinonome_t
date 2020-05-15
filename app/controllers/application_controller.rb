class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login
  before_action :user_logged_in?

  def user_logged_in?
    redirect_to :root if current_user.administrator
  end

  private
  def not_authenticated
    redirect_to :root, :alert => 'ログインをしてください'
  end
end
