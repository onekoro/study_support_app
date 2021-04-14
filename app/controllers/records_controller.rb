class RecordsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_recorder, only: [:edit, :update, :destroy]
  
  def new
    @place = Place.all
    @record = Record.new
  end
  
  def create
    @record = Record.new(record_params)
    @record.user_id = current_user.id
    if @record.save
      flash[:success] = "学習内容を記録しました"
      redirect_to record_show_user(current_user)
    else
      # flash[:danger] = "内容に不備があります"
      render new_record_path
    end
  end
  
  def edit
    @place = Place.all
    @record = Record.find(params[:id])
  end
  
  def update
    @record = Record.find(params[:id])
    if @record.update(record_params)
      flash[:success] = "更新しました"
      redirect_to record_show_user(current_user)
    else
      # flash[:danger] = "内容に不備があります"
      render new_record_path
    end
  end
  
  def destroy
    @record = Record.find(params[:id])
    Record.destroy
    flash[:success] = "削除しました"
    redirect_to record_show_user(current_user)
  end
  
  private
  
    def record_params
      params.require(:record).permit(:date, :hour, :minute, :place_id)
    end
    
    def correct_recorder
      @record = Record.find(params[:id])
      unless @record.user == current_user || current_user.admin
        redirect_to record_show_user_path(current_user)
      end
    end
        
end
