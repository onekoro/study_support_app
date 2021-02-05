class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
       log_in @user
       flash[:success] = "ユーザー登録ができました"
       redirect_to @user
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが違います"
      render 'new'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end
end
