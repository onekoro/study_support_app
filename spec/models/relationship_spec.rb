require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:relationship) { create(:relationship) }
  
  it "ファクトリが有効" do
    expect(relationship).to be_valid
  end
  
  it { is_expected.to validate_presence_of :follower_id }
  it { is_expected.to validate_presence_of :followed_id }
  
  describe "userが削除された時" do
    it "active_relationshipsも削除" do
      active_relationship = create(:active_relationship)
      user = active_relationship.follower
      expect{ user.destroy }.to change{ Relationship.count }.by(-1)
    end
  end
  
  describe "userが削除された時" do
    it "passive_relationshipsも削除" do
      passive_relationship = create(:passive_relationship)
      user = passive_relationship.followed
      expect{ user.destroy }.to change{ Relationship.count }.by(-1)
    end
  end
end
