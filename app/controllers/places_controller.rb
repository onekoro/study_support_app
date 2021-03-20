class PlacesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_poster, only: [:edit, :update, :destroy]
  
  def index
    @q = Place.ransack(params[:q])
    @places = @q.result(distinct: true).page(params[:page]).per(6)
    @tag_list = Tag.all
  end
  
  def  tag_search
    @tag = Tag.find(params[:tag_id])  #クリックしたタグを取得
    @places = @tag.places.page(params[:page]).per(6)
    @tag_list = Tag.all
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
    redirect_to places_url
  end
  
  private
  
    def place_params
      params.require(:place).permit(:title, :content, :image, :address, :web, :cost, :wifi, :recommend, :latitude, :longitude)
    end
    
    def correct_poster
      unless Place.find(params[:id]).user_id.to_i == current_user.id || current_user.admin?
        redirect_to tasks_path(current_user)
      end
    end
      
end
