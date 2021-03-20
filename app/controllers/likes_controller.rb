class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @place = Place.find(params[:place_id])
    unless @place.good?(current_user)
      @place.good(current_user)
      @place.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @place = Like.find(params[:id]).place
    if @place.good?(current_user)
      @place.ungood(current_user)
      @place.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end