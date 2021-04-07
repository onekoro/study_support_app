class SessionsController < ApplicationController
  before_action :unlogged_in_user, only: [:new, :create, :new_guest]
  before_action :logged_in_user, only: [:destroy]
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = "ログインしました"
      redirect_back_or root_path
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが異なります"
      render 'new'
    end
  end
  
  def new_guest
    user = User.find_by(email: 'guest@example.com') 
    log_in user
    flash[:success] = "ゲストユーザーとしてログインしました"
    redirect_back_or root_path
  end

  def destroy
    log_out
    flash[:success] = "ログアウトしました"
    redirect_back_or root_path
  end
end