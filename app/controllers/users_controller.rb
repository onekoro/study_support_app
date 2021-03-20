class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :check_guest, only: [:edit, :destroy]
  
  def index
    @user = current_user
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(20)
  end
  
  def show
    @user = User.find(params[:id])
    @places = Place.find_by(user_id: @user.id)
    # @places = Kaminari.paginate_array(@places).page(params[:page]).per(10)
    # @places = @places.page(params[:page]).per(10)
  end
  
  def like_show
    @user = User.find(params[:id])
    @places = @user.good_places
    @places = @places.page(params[:page]).per(6)
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
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "削除しました"
    redirect_to users_url
  end
  
  def following
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(100)
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(100)
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end
    
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user.admin? || current_user?(@user)
    end
    
    # ゲストユーザーか確認
    def check_guest
      if current_user.email == 'guest@example.com'
        flash[:danger] = 'ゲストユーザーは編集・削除できません。'
        redirect_to user_path(current_user)
      end
    end

    
end