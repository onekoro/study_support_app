require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "#index" do
    let(:user) { FactoryBot.create(:user) }
    
    context "ユーザがログイン済みの時" do
      it "正常にレスポンスを返す" do
        sign_in user
        get users_path
        aggregate_failures do
          expect(response).to be_successful
          expect(response).to have_http_status "200"
        end
      end
    end
  
    context "ユーザーがログインしていない時" do
      it "302レスポンスを返す" do
        get users_path
        aggregate_failures do
          expect(response).to have_http_status "302"
          expect(response).to redirect_to login_path
        end
      end
    end
  end
  
  describe "#show" do
    let(:user) { FactoryBot.create(:user) }
    
    context "ユーザーがログイン済みの時" do
      it "正常にレスポンスを返す" do
        sign_in user
        get user_path(user)
        aggregate_failures do
          expect(response).to be_successful
          expect(response).to have_http_status "200"
        end
      end
    end
  
    context "ユーザーがログインしていない時" do
      it "302レスポンスを返す" do
        get user_path(user)
        aggregate_failures do
          expect(response).to have_http_status "302"
          expect(response).to redirect_to login_path
        end
      end
    end
  end
  
  describe "#new" do
    let(:user) { FactoryBot.create(:user) }
    
    context "ユーザーがログインしていない時" do
      it "正常にレスポンスを返す" do
        get new_user_path(user)
        aggregate_failures do
          expect(response).to have_http_status "200"
          expect(response).to be_successful
        end
      end
    end
    
    context "ユーザーがログインしている時" do
      it "302レスポンスを返す" do
        sign_in user
        get new_user_path
        aggregate_failures do
          expect(response).to have_http_status "302"
          expect(response).to redirect_to user_path(user)
        end
      end
    end
  end
end

