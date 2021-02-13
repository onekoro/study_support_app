class PlacesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_poster, only: [:edit, :update, :destroy]
  
  def show
    @place = Place.find(params[:id])
  end
  
  def new
    @place = Place.new
  end
  
  def create
    @place = current_user.places.build(place_params)
    if @place.save
      flash[:success] = "勉強場所の登録ができました"
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
    if @place.update(place_params)
      flash[:success] = "勉強場所の更新をしました"
      redirect_to @place
    else
      render 'edit'
    end
  end
  
  
  private
  
    def place_params
      params.require(:place).permit(:title, :content)
    end
    
    def correct_poster
      unless Place.find(params[:id]).user_id.to_i == current_user.id || current_user.admin?
        redirect_to tasks_path(current_user)
      end
    end
      
end
