require 'rails_helper'

RSpec.describe "Relationships", type: :request do
    describe "#create" do
        let(:page_user) { create(:user) }
        let(:follower) { create(:user) }
        let(:followed) { create(:user) }
    
        context "ユーザーがログイン済の時" do
            it "フォローができる" do
                sign_in follower
                post relationships_path, params: { page_user_id: page_user.id, followed_id: followed.id }
                aggregate_failures do
                    expect(Relationship.count).to eq 1
                end
            end
        end
        
        context "ユーザーがログインしていない時" do
            it "ログインページに戻る" do
                post relationships_path, params: { page_user_id: page_user.id, followed_id: followed.id }
                aggregate_failures do
                    expect(Relationship.count).not_to eq 1
                    expect(response).to redirect_to login_path
                end
            end
        end
        
        context "すでにフォロー済みのユーザーをフォローしようとした時" do
            it "フォローできない" do
                sign_in follower
                create(:relationship, follower_id: follower.id, followed_id: followed.id)
                post relationships_path, params: { page_user_id: page_user.id, followed_id: followed.id }
                aggregate_failures do
                    expect(Relationship.count).not_to eq 2
                end
            end
        end
    end
    
    describe "#destroy" do
        let(:page_user) { create(:user) }
        let(:follower) { create(:user) }
        let(:followed) { create(:user) }
        let(:relationship) { create(:relationship, follower_id: follower.id, followed_id: followed.id) }
    
        context "ユーザーがログイン済の時" do
            it "フォロー解除ができる" do
                sign_in follower
                delete relationship_path(relationship.id), params: { page_user_id: page_user.id, followed_id: followed.id }
                aggregate_failures do
                    expect(Relationship.count).to eq 0
                end
            end
        end
        
        context "ユーザーがログインしていない時" do
            it "ログインページに戻る" do
                delete relationship_path(relationship.id), params: { page_user_id: page_user.id, followed_id: followed.id }
                aggregate_failures do
                    expect(Relationship.count).not_to eq 0
                    expect(response).to redirect_to login_path
                end
            end
        end
    end
end
