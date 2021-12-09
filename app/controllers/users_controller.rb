class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :like_show, :edit, :update, :destroy, :following, :followers, :record_show]
  before_action :unlogged_in_user, only: [:new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :check_guest, only: [:edit, :destroy]

  def index
    @user = current_user
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
    @places = Place.where(user_id: @user.id)
    @places = Kaminari.paginate_array(@places).page(params[:page]).per(6)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def like_show
    @user = User.find(params[:id])
    @places = @user.good_places
    @places = @places.page(params[:page]).per(6)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(100)
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(100)
  end

  def record_show
    @user = User.find(params[:id])
    # user_idによる絞り込み
    @user_record = Record.where(user_id: @user.id)
    # 週のデータ
    @week_data = week_record(@user_record) unless sum_week_record(@user_record) == 0
    # 週の総学習時間
    @sum_week_time = sum_week_record(@user_record)
    # 日付による絞り込み
    @q = @user_record.ransack(params[:q])
    # 入力値がなければ今日のデータを入力
    if params[:q].nil?
      @q.date_eq = Date.today
    end
    @records = @q.result(distinct: true)
    # 1日の総学習時間
    @sum_day_time = sum_day_record(@records)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザー登録ができました"
      redirect_to root_path
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
      redirect_to record_show_user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "削除しました"
    if user == current_user
      redirect_to root_path
    else
      redirect_to users_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      unless current_user.admin? || current_user?(@user)
        flash[:danger] = "他のユーザーの編集・削除はできません"
        redirect_to record_show_user_path(current_user)
      end
    end

    # ゲストユーザーか確認
    def check_guest
      if current_user.email == 'guest@example.com'
        flash[:danger] = 'ゲストユーザーは編集・削除できません。'
        redirect_to record_show_user_path(current_user)
      end
    end


end
