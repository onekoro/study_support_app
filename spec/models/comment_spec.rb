require 'rails_helper'

RSpec.describe Comment, type: :model do
    let!(:comment) { create(:comment) }
    
    it "ファクトリが有効" do
        expect(comment).to be_valid
    end
    
    it { is_expected.to validate_presence_of :content }
    it { is_expected.to validate_length_of(:content).is_at_most(400) }
    it { is_expected.to validate_presence_of :recommend }
    it { is_expected.to validate_uniqueness_of(:place_id).scoped_to(:user_id) }
    
    describe "userが削除された時" do
        it "commentも削除" do
            user = comment.user
            expect{ user.destroy }.to change{ Comment.count }.by(-1)
        end
    end
    
    describe "placeが削除された時" do
        it "commentも削除" do
            place = comment.place
            expect{ place.destroy }.to change{ Comment.count }.by(-1)
        end
    end
end
