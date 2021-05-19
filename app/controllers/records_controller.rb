class RecordsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_recorder, only: [:edit, :update, :destroy]
  before_action :set_place_search, only: [:new, :edit]
  
  def new
    @record = Record.new
    @path = new_record_path
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def create
    @record = Record.new(record_params)
    @record.user_id = current_user.id
    if @record.save
      flash[:success] = "学習内容を記録しました"
      redirect_to record_show_user_path(current_user)
    else
      set_place_search
      render new_record_path
    end
  end
  
  def edit
    @record = Record.find(params[:id])
    @path = edit_record_path(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def update
    @record = Record.find(params[:id])
    if @record.update(record_params)
      flash[:success] = "更新しました"
      redirect_to record_show_user_path(@record.user)
    else
      set_place_search
      render record_edit_path(params[:id])
    end
  end
  
  def destroy
    record = Record.find(params[:id])
    record_user = record.user
    record.destroy
    flash[:success] = "削除しました"
    redirect_to record_show_user_path(record_user)
  end
  
  private
  
    def record_params
      params.require(:record).permit(:date, :hour, :minute, :content, :place_id)
    end
    
    def correct_recorder
      @record = Record.find(params[:id])
      unless @record.user_id.to_i == current_user.id || current_user.admin?
        redirect_to record_show_user_path(@record.user)
      end
    end
        
end
