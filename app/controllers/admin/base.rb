class Admin::Base < ApplicationController
  layout 'admin/dashboard'

  before_action :require_login
  before_action :user_logged_in?

  def user_logged_in?
    redirect_to :root unless current_user.administrator
  end
end
