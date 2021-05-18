require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "#create" do
    let!(:user) { create(:user) }
    let(:place) { create(:place) }
    let(:comment) { attributes_for(:comment, user_id: user.id, place_id: place.id) }
    
    context "ユーザーがログインしている時" do
      it "正常にレスポンスを返す" do
        sign_in user
        post place_comments_path(place.id), params: { comment: comment }
        aggregate_failures do
          expect(Comment.count).to eq 1
          expect(response).to redirect_to place_path(place)
        end
      end
    end
    
    context "ユーザーがログインしていない時" do
      it "ログインページに戻る" do
        post place_comments_path(place.id), params: { comment: comment }
        aggregate_failures do
          expect(Comment.count).not_to eq 1
          expect(response).to redirect_to login_path
        end
      end
    end
    
    context "無効な属性値の時" do
      it "投稿詳細ページにレンダーする" do
        sign_in user
        comment[:content] = nil
        post place_comments_path(place.id), params: { comment: comment }
        aggregate_failures do
          expect(Comment.count).not_to eq 1
          expect(response).to render_template "places/show"
        end
      end
    end
  end
  
  describe "#destroy" do
    let!(:comment) { create(:comment) }
    let(:place) { comment.place }
    let(:user) { comment.user }
    
    context "ユーザーがログインしている時" do
      it "自分のコメントを削除できる" do
        sign_in user
        delete place_comment_path(place_id: place.id, id: comment.id)
        aggregate_failures do
          expect(Comment.count).to eq 0
          expect(response).to redirect_to place_path(place)
        end
      end
    end
    
    context "ユーザーがログインしていない時" do
      it "ログインページに戻る" do
        delete place_comment_path(place_id: place.id, id: comment.id)
        aggregate_failures do
          expect(Comment.count).to eq 1
          expect(response).to redirect_to login_path
        end
      end
    end
    
    context "管理者権限のあるユーザーの時" do
      it "他のユーザーのコメントを削除できる" do
        other_user = create(:user, admin: true)
        sign_in other_user
        delete place_comment_path(place_id: place.id, id: comment.id)
        aggregate_failures do
          expect(Comment.count).to eq 0
          expect(response).to redirect_to place_path(place)
        end
      end
    end
    
    context "管理者権限のないユーザーの時" do
      it "他のユーザーのコメントを削除できない" do
        other_user = create(:user)
        sign_in other_user
        delete place_comment_path(place_id: place.id, id: comment.id)
        aggregate_failures do
          expect(Comment.count).to eq 1
          expect(response).to redirect_to place_path(place)
        end
      end
    end
  end
end