require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    context "ユーザがログイン済みの時" do
      before do
        @user = FactoryBot.create(:user)
      end
      
      it "正常にレスポンスを返す" do
        log_in @user
        get :index, params: { id: @user.id }
        expect(response).to be_successful
      end
      
      it "200レスポンスを返す" do
        log_in @user
        get :index, params: { id: @user.id }
        expect(response).to have_http_status "200"
      end
    end
  
    context "ユーザーがログインしていない時" do
      it "302レスポンスを返す" do
        get :index
        expect(response).to have_http_status "302"
      end
      
      it "ログインページにリダイレクトする" do
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end
  
  describe "#show" do
    before do
      @user = FactoryBot.create(:user)
    end
    
    it "正常にレスポンスを返す" do
      get :show, params: { id: @user.id }
      expect(response).to be_successful
    end
    
    it "200レスポンスを返す" do
      get :show, params: { id: @user.id }
      expect(response).to have_http_status "200"
    end
  end
  
end
