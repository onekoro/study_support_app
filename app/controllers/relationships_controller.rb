class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @target_user = User.find(params[:followed_id])
    @user = User.find(params[:page_user_id])
    unless current_user.following?(@target_user)
      current_user.follow(@target_user)
      respond_to do |format|
        format.html { redirect_to @target_user }
        format.js
      end
    # else
    #   unless current_user.following?(@page_user)
    #     current_user.follow(@page_user)
    #     respond_to do |format|
    #       format.html { redirect_to @user }
    #       format.js
    #     end
    #   end
    end
  end

  def destroy
    @target_user = Relationship.find(params[:id]).followed
    @user = User.find(params[:page_user_id])
    if current_user.following?(@target_user)
      current_user.unfollow(@target_user)
      respond_to do |format|
        format.html { redirect_to @target_user }
        format.js
      end
    # else
    #   unless current_user.following?(@page_user)
    #     current_user.unfollow(@page_user)
    #     respond_to do |format|
    #       format.html { redirect_to @user }
    #       format.js
    #     end
    #   end
    end
    
  end
end
