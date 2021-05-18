require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "#index" do
    let(:user) { create(:user) }
    
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
    let(:user) { create(:user) }
    
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
  
  describe "#like_show" do
    let(:user) { create(:user) }
    
    context "ユーザーがログイン済みの時" do
      it "正常にレスポンスを返す" do
        sign_in user
        get like_show_user_path(user)
        aggregate_failures do
          expect(response).to be_successful
          expect(response).to have_http_status "200"
        end
      end
    end
  
    context "ユーザーがログインしていない時" do
      it "ログインページに移動する" do
        get like_show_user_path(user)
        aggregate_failures do
          expect(response).to have_http_status "302"
          expect(response).to redirect_to login_path
        end
      end
    end
  end
  
  describe "#following" do
    let(:user) { create(:user) }
    
    context "ユーザーがログイン済みの時" do
      it "正常にレスポンスを返す" do
        sign_in user
        get following_user_path(user)
        aggregate_failures do
          expect(response).to be_successful
          expect(response).to have_http_status "200"
        end
      end
    end
  
    context "ユーザーがログインしていない時" do
      it "ログインページに移動する" do
        get following_user_path(user)
        aggregate_failures do
          expect(response).to have_http_status "302"
          expect(response).to redirect_to login_path
        end
      end
    end
  end
  
  describe "#followers" do
    let(:user) { create(:user) }
    
    context "ユーザーがログイン済みの時" do
      it "正常にレスポンスを返す" do
        sign_in user
        get followers_user_path(user)
        aggregate_failures do
          expect(response).to be_successful
          expect(response).to have_http_status "200"
        end
      end
    end
  
    context "ユーザーがログインしていない時" do
      it "ログインページに移動する" do
        get followers_user_path(user)
        aggregate_failures do
          expect(response).to have_http_status "302"
          expect(response).to redirect_to login_path
        end
      end
    end
  end
  
  describe "#record_show" do
    let(:user) { create(:user) }
    
    context "ユーザーがログイン済みの時" do
      it "正常にレスポンスを返す" do
        sign_in user
        get record_show_user_path(user)
        aggregate_failures do
          expect(response).to be_successful
          expect(response).to have_http_status "200"
        end
      end
    end
  
    context "ユーザーがログインしていない時" do
      it "ログインページに移動する" do
        get record_show_user_path(user)
        aggregate_failures do
          expect(response).to have_http_status "302"
          expect(response).to redirect_to login_path
        end
      end
    end
  end
  
  describe "#new" do
    let(:user) { create(:user) }
    
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
  
  describe "#create" do
    let(:user) { attributes_for(:user) }
    
    context "ユーザーがログインしていない時" do
      it "正常にレスポンスを返す" do
        user[:password_confirmation] = user[:password]
        post users_path, params: { user: user }
        aggregate_failures do
          expect(User.count).to eq 1
          expect(response).to redirect_to root_path
        end
      end
    end
    
    context "ユーザーがログインしている時" do
      it "ユーザー詳細ページに戻る" do
        user = create(:user)
        sign_in user
        post users_path
        aggregate_failures do
          expect(response).to redirect_to user_path(user)
        end
      end
    end
    
    context "無効な属性値の時" do
      it "新規作成ページに戻る" do
        user = attributes_for(:user, :invalid)
        user[:password_confirmation] = user[:password]
        post users_path, params: { user: user }
        aggregate_failures do
          expect(response).to have_http_status "200"
          expect(response).to render_template :new
        end
      end
    end
  end
  
  describe "#edit" do
    let(:user) { create(:user) }
    
    context "ユーザーがログインしている時" do
      it "正常にレスポンスを返す" do
        sign_in user
        get edit_user_path(user)
        aggregate_failures do
          expect(response).to have_http_status "200"
          expect(response).to be_successful
        end
      end
    end
    
    context "ユーザーがログインしていない時" do
      it "ログインページに戻る" do
        get edit_user_path(user)
        aggregate_failures do
          expect(response).to have_http_status "302"
          expect(response).to redirect_to login_path
        end
      end
    end
    
    context "別のユーザーを編集しようとした時" do
      it "マイページに戻る" do
        other_user = create(:user)
        sign_in other_user
        get edit_user_path(user)
        aggregate_failures do
          expect(response).to have_http_status "302"
          expect(response).to redirect_to user_path(other_user)
        end
      end
    end
  end
  
  describe "#update" do
    let(:user) { create(:user) }
    
    context "ユーザーがログインしている時" do
      it "自分のアカウントの編集ができる" do
        sign_in user
        user_params = attributes_for(:user, name: "new_name", email: "new@new.com", password: "newpass", password_confirmation: "newpass")
        patch user_path(user.id), params: { user: user_params }
        aggregate_failures do
          expect(user.reload.name).to eq "new_name"
          expect(user.reload.email).to eq "new@new.com"
          # expect(user.reload.password).to eq "newpass"
          expect(response).to redirect_to user_path(user)
        end
      end
    end
    
    
    context "ユーザーがログインしていない時" do
      it "ログインページに戻る" do
        user_params = attributes_for(:user, name: "new_name", email: "new@new.com", password: "newpass", password_confirmation: "newpass")
        patch user_path(user.id), params: { user: user_params }
        aggregate_failures do
          expect(user.reload.name).not_to eq "new_name"
          expect(user.reload.email).not_to eq "new@new.com"
          # expect(user.reload.password).not_to eq "newpass"
          expect(response).to redirect_to login_path
        end
      end
    end
    
    context "管理者権限のあるユーザーの時" do
      it "他のユーザーを編集できる" do
        other_user = create(:user, admin: true)
        sign_in other_user
        user_params = attributes_for(:user, name: "new_name", email: "new@new.com", password: "newpass", password_confirmation: "newpass")
        patch user_path(user.id), params: { user: user_params }
        aggregate_failures do
          expect(user.reload.name).to eq "new_name"
          expect(user.reload.email).to eq "new@new.com"
          # expect(user.reload.password).not_to eq "newpass"
          expect(response).to redirect_to user_path(user)
        end
      end
    end
    
    context "管理者権限のないユーザーの時" do
      it "他のユーザーを編集できない" do
        other_user = create(:user)
        sign_in other_user
        user_params = attributes_for(:user, name: "new_name", email: "new@new.com", password: "newpass", password_confirmation: "newpass")
        patch user_path(user.id), params: { user: user_params }
        aggregate_failures do
          expect(user.reload.name).not_to eq "new_name"
          expect(user.reload.email).not_to eq "new@new.com"
          # expect(user.reload.password).not_to eq "newpass"
          expect(response).to redirect_to user_path(other_user)
        end
      end
    end
  end
  
  describe "#destroy" do
    let(:user) { create(:user) }
    
    context "ユーザーがログインしている時" do
      it "自分のアカウントを削除できる" do
        sign_in user
        delete user_path(user.id)
        aggregate_failures do
          expect(User.count).to eq 0
          expect(response).to redirect_to root_path
        end
      end
    end
    
    context "ユーザーがログインしていない時" do
      it "ログインページに戻る" do
        delete user_path(user.id)
        aggregate_failures do
          expect(User.count).to eq 1
          expect(response).to redirect_to login_path
        end
      end
    end
    
    context "管理者権限のあるユーザーの時" do
      it "他のユーザーを削除できる" do
        other_user = create(:user, admin: true)
        sign_in other_user
        delete user_path(user.id)
        aggregate_failures do
          expect(User.count).to eq 1
          expect(response).to redirect_to users_path
        end
      end
    end
    
    context "管理者権限のないユーザーの時" do
      it "他のユーザーを削除できない" do
        other_user = create(:user)
        sign_in other_user
        delete user_path(user.id)
        aggregate_failures do
          expect(User.count).to eq 2
          expect(response).to redirect_to user_path(other_user)
        end
      end
    end
  end
end

