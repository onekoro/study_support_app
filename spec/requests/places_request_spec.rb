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
  
  describe "#tag_search" do
    let!(:place) { create(:place) }
    let!(:tag) { create(:tag) }
    
    context "タグが存在する時" do
      it "正常にレスポンスを返す" do
        get tag_search_place_path(tag)
        aggregate_failures do
          expect(response).to be_successful
          expect(response).to have_http_status "200"
        end
      end
    end
  end
  
  describe "#show" do
    let(:place) { create(:place) }
    
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
    let(:user) { create(:user) }
    
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
    let!(:place) { build(:place) }
    let!(:tag) { build(:tag) }

    context "ユーザーがログイン済みの時" do
      it "場所の追加ができる" do
        user = place.user
        sign_in user
        place_params = { title: place.title, content: place.content, address: place.address, web: place.web, cost: place.cost, wifi: place.wifi, recommend: place.recommend, tag_name: tag.tag_name }
        post places_path, params: { place: place_params }
        aggregate_failures do
          expect(user.places.count).to eq 1
          # expect(place.tags.reload.count).to eq 1
          expect(response).to redirect_to place_path(Place.last)
        end
      end
    end
    
    context "ユーザーがログインしていない時" do
      it "302レスポンスを返す" do
        place_params = attributes_for(:place)
        place_params[:tag_name] = tag.tag_name
        post places_path, params: { place: place_params }
        aggregate_failures do
          expect(response).to have_http_status "302"
          expect(response).to redirect_to login_url
        end
      end
    end
    
    context "無効な属性値の時" do
      it "新規作成ページに戻る" do
        user = place.user
        sign_in user
        place_params = { title: "", content: place.content, address: place.address, web: place.web, cost: place.cost, wifi: place.wifi, recommend: place.recommend }
        place_params[:tag_name] = tag.tag_name
        post places_path, params: { place: place_params }
        aggregate_failures do
          expect(user.places.count).to eq 0
          expect(response).to render_template :new
        end
      end
    end
  end
  
  describe "#edit" do
    let!(:place) { create(:place) }
    let!(:tag) { create(:tag) }
    
    context "ユーザーがログインしている時" do
      it "正常にレスポンスを返す" do
        sign_in place.user
        get edit_place_path(place)
        aggregate_failures do
          expect(response).to have_http_status "200"
          expect(response).to be_successful
        end
      end
    end
    
    context "ユーザーがログインしていない時" do
      it "ログインページに戻る" do
        get edit_place_path(place)
        aggregate_failures do
          expect(response).to have_http_status "302"
          expect(response).to redirect_to login_path
        end
      end
    end
    
    context "管理者権限のあるユーザーが編集しようとした時" do
      it "正常にレスポンスを返す" do
        other_user = create(:user, admin: true)
        sign_in other_user
        get edit_place_path(place)
        aggregate_failures do
          expect(response).to have_http_status "200"
          expect(response).to be_successful
        end
      end
    end
    
    context "管理者権限のないユーザーが編集しようとした時" do
      it "マイページに戻る" do
        other_user = create(:user)
        sign_in other_user
        get edit_place_path(place)
        aggregate_failures do
          expect(response).to have_http_status "302"
          expect(response).to redirect_to user_path(other_user)
        end
      end
    end
  end
  
  describe "#update" do
    let!(:place) { create(:place) }
    let!(:tag) { create(:tag) }
    
    context "ユーザーがログインしている時" do
      it "自分の投稿の編集ができる" do
        sign_in  place.user
        place_params = attributes_for(:place, title: "new_title", content: "new_content", address: "new_address", web: "new_web.com", cost: 0, wifi: "なし", recommend: 2)
        place_params[:tag_name] = tag.tag_name
        patch place_path(place.id), params: { place: place_params }
        aggregate_failures do
          expect(place.reload.title).to eq "new_title"
          expect(place.reload.content).to eq "new_content"
          expect(place.reload.address).to eq "new_address"
          expect(place.reload.web).to eq "new_web.com"
          expect(place.reload.cost).to eq 0
          expect(place.reload.wifi).to eq "なし"
          expect(place.reload.recommend).to eq 2
          expect(response).to redirect_to place_path(place)
        end
      end
    end
    
    
    context "ユーザーがログインしていない時" do
      it "ログインページに戻る" do
        place_params = attributes_for(:place, content: "new_content", address: "new_address", web: "new_web.com", cost: 0, wifi: "なし", recommend: 2)
        place_params[:tag_name] = tag.tag_name
        patch place_path(place.id), params: { place: place_params }
        aggregate_failures do
          expect(place.reload.title).not_to eq "title2"
          expect(place.reload.content).not_to eq "new_content"
          expect(place.reload.address).not_to eq "new_address"
          expect(place.reload.web).not_to eq "new_web.com"
          expect(place.reload.cost).not_to eq 0
          expect(place.reload.wifi).not_to eq "なし"
          expect(place.reload.recommend).not_to eq 2
          expect(response).to redirect_to login_path
        end
      end
    end
    
    context "管理者権限のあるユーザーの時" do
      it "他のユーザーの投稿を編集できる" do
        other_user = create(:user, admin: true)
        sign_in other_user
        place_params = attributes_for(:place, title: "new_title", content: "new_content", address: "new_address", web: "new_web.com", cost: 0, wifi: "なし", recommend: 2)
        place_params[:tag_name] = tag.tag_name
        patch place_path(place.id), params: { place: place_params }
        aggregate_failures do
          expect(place.reload.title).to eq "new_title"
          expect(place.reload.content).to eq "new_content"
          expect(place.reload.address).to eq "new_address"
          expect(place.reload.web).to eq "new_web.com"
          expect(place.reload.cost).to eq 0
          expect(place.reload.wifi).to eq "なし"
          expect(place.reload.recommend).to eq 2
          expect(response).to redirect_to place_path(place)
        end
      end
    end
    
    context "管理者権限のないユーザーの時" do
      it "他のユーザーを編集できない" do
        other_user = create(:user)
        sign_in other_user
        place_params = attributes_for(:place, content: "new_content", address: "new_address", web: "new_web.com", cost: 0, wifi: "なし", recommend: 2)
        place_params[:tag_name] = tag.tag_name
        patch place_path(place.id), params: { place: place_params }
        aggregate_failures do
          expect(place.reload.title).not_to eq "title2"
          expect(place.reload.content).not_to eq "new_content"
          expect(place.reload.address).not_to eq "new_address"
          expect(place.reload.web).not_to eq "new_web.com"
          expect(place.reload.cost).not_to eq 0
          expect(place.reload.wifi).not_to eq "なし"
          expect(place.reload.recommend).not_to eq 2
          expect(response).to redirect_to user_path(other_user)
        end
      end
    end
  end
  
  describe "#destroy" do
    let!(:place) { create(:place) }
    # let!(:tag) { create(:tag) }
    
    context "ユーザーがログインしている時" do
      it "自分の投稿を削除できる" do
        user = place.user
        sign_in user
        delete place_path(place.id)
        aggregate_failures do
          expect(user.places.count).to eq 0
          expect(response).to redirect_to user_path(user)
        end
      end
    end
    
    context "ユーザーがログインしていない時" do
      it "ログインページに戻る" do
        user = place.user
        delete place_path(place.id)
        aggregate_failures do
          expect(user.places.count).to eq 1
          expect(response).to redirect_to login_path
        end
      end
    end
    
    context "管理者権限のあるユーザーの時" do
      it "他のユーザーの投稿を削除できる" do
        user = place.user
        other_user = create(:user, admin: true)
        sign_in other_user
        delete place_path(place.id)
        aggregate_failures do
          expect(user.places.count).to eq 0
          expect(response).to redirect_to user_path(other_user)
        end
      end
    end
    
    context "管理者権限のないユーザーの時" do
      it "他のユーザーの投稿を削除できない" do
        user = place.user
        other_user = create(:user)
        sign_in other_user
        delete place_path(place.id)
        aggregate_failures do
          expect(user.places.count).to eq 1
          expect(response).to redirect_to user_path(other_user)
        end
      end
    end
  end
end
