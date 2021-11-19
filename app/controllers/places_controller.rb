class PlacesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_poster, only: [:edit, :update, :destroy]
  before_action :set_place_search, only: [:index]

  def index
    # @good_places = Place.find(Like.group(:place_id).order('count(place_id) desc').limit(3).pluck(:place_id))
    @good_places = Place.includes(:good_users).sort {|a,b| b.good_users.size <=> a.good_users.size}.first(3)
    @tags = Tag.find(TagMap.group(:tag_id).order('count(tag_id) desc').limit(15).pluck(:tag_id))
    @path = places_path
    respond_to do |format|
      format.html
      format.js
    end
  end

  def  tag_search
    @tag = Tag.find(params[:id])  #クリックしたタグを取得
    @places = @tag.places.page(params[:page]).per(6)
    @tags = Tag.find(TagMap.group(:tag_id).order('count(tag_id) desc').pluck(:tag_id))
  end

  def show
    @place = Place.find(params[:id])
    @comments = @place.comments
    @comment = Comment.new
    @place_tags = @place.tags
  end

  def new
    @place = Place.new
  end

  def create
    @place = current_user.places.build(place_params)
    tag_list = params[:place][:tag_name].split(nil)
    if @place.save
      @place.save_tag(tag_list)
      flash[:success] = "勉強場所を投稿しました"
      redirect_to @place
    else
      render 'new'
    end
  end

  def edit
    @place = Place.find(params[:id])
  end

  def update
    @place = Place.find(params[:id])
    tag_list = params[:place][:tag_name].split(nil)
    if @place.update(place_params)
      @place.save_tag(tag_list)
      flash[:success] = "勉強場所の更新をしました"
      redirect_to @place
    else
      render 'edit'
    end
  end

  def destroy
    Place.find(params[:id]).destroy
    flash[:success] = "勉強場所を削除しました"
    redirect_to record_show_user_path(current_user)
  end

  private

    def place_params
      params.require(:place).permit(:title, :content, :image, :address, :web, :cost, :wifi, :recommend)
    end

    def correct_poster
      unless Place.find(params[:id]).user_id.to_i == current_user.id || current_user.admin?
        flash[:danger] = "この投稿を編集・削除する権限はありません"
        redirect_to record_show_user_path(current_user)
      end
    end

end
