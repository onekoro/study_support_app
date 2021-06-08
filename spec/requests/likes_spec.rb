require 'rails_helper'

RSpec.describe "Likes", type: :request do
  describe "#create" do
    let(:user) { create(:user) }
    let(:place) { create(:place) }
    
    context "ユーザーがログイン済みの時" do
      it "いいねできる" do
        sign_in user
        post likes_path, params: { place_id: place.id }
        aggregate_failures do
          expect(Like.count).to eq 1
        end
      end
    end
    
    context "ユーザーがログインしていない時" do
      it "ログインページに戻る" do
        post likes_path, params: { place_id: place.id }
        aggregate_failures do
          expect(Like.count).not_to eq 1
          expect(response).to redirect_to login_path
        end
      end
    end
    
    context "いいね済みの投稿をいいねしようとした時" do
      it "いいねできない" do
        sign_in user
        create(:like, user: user, place: place)
        post likes_path, params: { place_id: place.id }
        aggregate_failures do
          expect(Like.count).not_to eq 2
        end
      end
    end
  end
  
  describe "#destroy" do
    let(:user) { create(:user) }
    let(:place) { create(:place) }
    let(:like) { create(:like, user: user, place: place) }
    
    context "ユーザーがログイン済みの時" do
      it "いいね解除ができる" do
        sign_in user
        delete like_path(like.id), params: { place_id: place.id }
        aggregate_failures do
          expect(Like.count).to eq 0
        end
      end
    end
    
    context "ユーザーがログインしていない時" do
      it "ログインページに戻る" do
        delete like_path(like.id), params: { place_id: place.id }
        aggregate_failures do
          expect(Like.count).not_to eq 0
          expect(response).to redirect_to login_path
        end
      end
    end
  end
end
