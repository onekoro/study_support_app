require 'rails_helper'

RSpec.describe PlacesController, type: :controller do
  describe "#index" do
    it "正常にレスポンスを返す" do
      get :index
      expect(response).to be_successful
    end
      
    it "200レスポンスを返す" do
      get :index
      expect(response).to have_http_status "200"
    end
  end
  
  # describe "#tag_search" do
  #   context "タグが存在する時"
  #     before do
  #       @tag = FactoryBot.create(:tag)
  #     end
  #     it "正常にレスポンスを返す" do
  #       get :tag_search, params: { id: @tag.id }
  #       expect(response).to be_successful
  #     end
        
  #     it "200レスポンスを返す" do
  #       get :tag_search, params: { id: @tag.id }
  #       expect(response).to have_http_status "200"
  #     end
  # end
  
  describe "#show" do
    context "投稿場所が存在する時" do
      before do
        @place = FactoryBot.create(:place)
      end
      
      it "正常にレスポンスを返す" do
        get :show, params: { id: @place.id }
        expect(response).to be_successful
      end
        
      it "200レスポンスを返す" do
        get :show, params: { id: @place.id }
        expect(response).to have_http_status "200"
      end
    end
  end
  
  describe "#new" do
    context "ユーザがログイン済みの時" do
      before do
        @user = FactoryBot.create(:user)
      end
      
      it "正常にレスポンスを返す" do
        log_in @user
        get :new
        expect(response).to be_successful
      end
      
      it "200レスポンスを返す" do
        log_in @user
        get :new
        expect(response).to have_http_status "200"
      end
    end
  
    context "ユーザーがログインしていない時" do
      it "302レスポンスを返す" do
        get :new
        expect(response).to have_http_status "302"
      end
      
      it "ログインページにリダイレクトする" do
        get :new
        expect(response).to redirect_to login_path
      end
    end
  end
  
  describe "#create" do
    context "ユーザーがログイン済みの時" do
      before do
        @user = FactoryBot.create(:user)
      end
      
      # it "場所の追加ができる" do
      #   place_params = FactoryBot.attributes_for(:place)
      #   log_in @user
      #   expect {
      #     post :create, params: { place: place_params }
      #   }.to change(@user.places, :count).by(1)
      # end
    end
    
    context "ユーザーがログインしていない時" do
      before do
        @user = FactoryBot.create(:user)
      end
      
      it "302レスポンスを返す" do
        place_params = FactoryBot.attributes_for(:place)
        post :create, params: { place: place_params }
        expect(response).to have_http_status "302"
      end
        
      it "新規投稿ページに戻る" do
        place_params = FactoryBot.attributes_for(:place)
        post :create, params: { place: place_params }
        expect(response).to redirect_to login_url
      end
    end
  end
end
