class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  def create
    @place = Place.find(params[:place_id])
    @comment = @place.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメントを投稿しました"
      redirect_to @place
    else
      flash[:danger] = "内容に不備があります"
      redirect_to @place
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
end
