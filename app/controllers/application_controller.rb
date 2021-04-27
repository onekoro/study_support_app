class ApplicationController < ActionController::Base
  include SessionsHelper
  include RecordsHelper
  
  private
  
    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
    
    def unlogged_in_user
      if logged_in?
        store_location
        flash[:danger] = "既にログイン済みです"
        redirect_to user_path(current_user)
      end
    end
    
    def set_place_search
      unless params[:q].present?
        params[:q] = { sorts: 'updated_at desc' }
      end
      @q = Place.ransack(params[:q])
      @places = @q.result(distinct: true).page(params[:page]).per(6)
    end
    
end
