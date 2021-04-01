require 'rails_helper'

RSpec.describe "Places", type: :request do
  describe "#index" do
    it "正常にレスポンスを返す" do
      get root_path
      aggregate_failures do
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
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
    let(:place) { FactoryBot.create(:place) }
    
    context "投稿場所が存在する時" do
      it "正常にレスポンスを返す" do
        get place_path(place)
        aggregate_failures do
          expect(response).to be_successful
          expect(response).to have_http_status "200"
        end
      end
    end
  end
  
  describe "#new" do
    let(:user) { FactoryBot.create(:user) }
    
    context "ユーザがログイン済みの時" do
      it "正常にレスポンスを返す" do
        sign_in user
        get new_place_path
        aggregate_failures do
          expect(response).to be_successful
          expect(response).to have_http_status "200"
        end
      end
    end
    
    context "ユーザーがログインしていない時" do
      it "302レスポンスを返す" do
        get new_place_path
        aggregate_failures do
          expect(response).to have_http_status "302"
          expect(response).to redirect_to login_path
        end
      end
    end
  end
  
  describe "#create" do
    let(:user) { FactoryBot.create(:user) }
    
    context "ユーザーがログイン済みの時" do
      # it "場所の追加ができる" do
      #   place_params = FactoryBot.attributes_for(:place)
      #   sign_in @user
      #   expect {
      #     post places_path, params: { place: place_params }
      #   }.to change(@user.places, :count).by(1)
      # end
    end
    
    context "ユーザーがログインしていない時" do
      it "302レスポンスを返す" do
        place_params = FactoryBot.attributes_for(:place)
        post places_path, params: { place: place_params }
        aggregate_failures do
          expect(response).to have_http_status "302"
          expect(response).to redirect_to login_url
        end
      end
    end
  end
end
