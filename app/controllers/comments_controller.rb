class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_commenter, only: [:destroy]
  
  def create
    @place = Place.find(params[:place_id])
    @comment = Comment.new(comment_params)
    @comment.place_id = @place.id
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメントを投稿しました"
      redirect_to @place
    else
      @comments = @place.comments
      @place_tags = @place.tags
      render "places/show"
    end
  end

  def destroy
    @place = Place.find(params[:place_id])
    @comment = Comment.find(params[:id]).destroy
    flash[:success] = "コメントを削除しました"
    redirect_to place_path(@place)
  end
  
  private

    def comment_params
      params.require(:comment).permit(:content, :recommend)
    end
    
    def correct_commenter
      @comment = Comment.find(params[:id])
      unless @comment.user_id.to_i == current_user.id || current_user.admin?
        flash[:danger] = "このコメントを削除する権限はありません"
        redirect_to place_path(@comment.place)
      end
    end
end
