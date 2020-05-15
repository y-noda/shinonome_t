class UserSessionsController < ApplicationController
  skip_before_action :user_logged_in?
  skip_before_action :require_login, except: [:destroy]

  def index
  end

  def create
    user = login(params[:name], params[:password])
    if user
      # userが管理者だったら管理画面、一般ユーザーだったらアプリ画面に遷移する
      if user.administrator
        # redirect_back_or_to '/admin/top'
        redirect_back_or_to admin_csv_export_index_path
      else
        redirect_back_or_to '/top'
      end
    else
      flash.alert = 'ユーザー名とパスワードが一致しません'
      redirect_back_or_to :root
    end
  end

  def destroy
    logout
    redirect_back_or_to :root
  end
end
