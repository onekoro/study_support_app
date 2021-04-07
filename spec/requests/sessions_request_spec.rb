require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "#new" do
    let(:user) { create(:user) }
    
    context "ログインしていない時" do
      it "正常にレスポンスを返す" do
        get login_path
        aggregate_failures do
          expect(response).to be_successful
          expect(response).to have_http_status "200"
        end
      end
    end
    
    context "ログインしている時" do
      it "マイページに移動する" do
        sign_in user
        get login_path
        aggregate_failures do
          expect(response).to redirect_to user_path(user)
          expect(response).to have_http_status "302"
        end
      end
    end
  end
  
  describe "#create" do
    let(:user) { create(:user) }
    
    context "アカウントが存在する時" do
      it "ログインする" do
        sign_in user
        aggregate_failures do
          expect(response).to redirect_to root_path
          expect(response).to have_http_status "302"
        end
      end
    end
    
    context "アカウントが存在しない時" do
      it "新規作成ページに移動する" do
        other_user = build(:user)
        sign_in other_user
        aggregate_failures do
          expect(response).to render_template :new
          expect(response).to have_http_status "200"
        end
      end
    end
    
    context "既にログインしている時" do
      it "マイページに移動する" do
        sign_in user
        sign_in user
        aggregate_failures do
          expect(response).to redirect_to user_path(user)
          expect(response).to have_http_status "302"
        end
      end
    end
  end
  
  describe "#destroy" do
    let(:user) { create(:user) }
    
    context "ログイン済みの時" do
      it "ログアウトする" do
        sign_in user
        delete logout_path
        aggregate_failures do
          expect(response).to redirect_to root_path
          expect(response).to have_http_status "302"
        end
      end
    end
    
    context "ログインしていない時" do
      it "ログインページに移動する" do
        delete logout_path
        aggregate_failures do
          expect(response).to redirect_to login_path
          expect(response).to have_http_status "302"
        end
      end
    end
  end
end
