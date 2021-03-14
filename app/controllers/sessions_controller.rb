class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = "ログインしました"
      redirect_to root_path
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが異なります"
      render 'new'
    end
  end
  
  def new_guest
    user = User.find_by(email: 'guest@example.com') 
    log_in user
    flash[:success] = "ゲストユーザーとしてログインしました"
    redirect_to root_path
  end

  def destroy
    if logged_in?
      log_out
      flash[:success] = "ログアウトしました"
    end
    redirect_to root_url
  end
end