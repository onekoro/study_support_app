require 'rails_helper'

RSpec.describe TagMap, type: :model do
  let!(:tag) { create(:tag) }
  let!(:place) { create(:place) }
  let!(:tag_map){ create(:tag_map, place: place, tag: tag) }
  
  it "ファクトリが有効" do
    expect(tag_map).to be_valid
  end
  
  it { is_expected.to validate_presence_of :place_id }
  it { is_expected.to validate_presence_of :tag_id }
  
  describe "tagが削除された時" do
    it "tag_mapも削除" do
      expect{ tag.destroy }.to change{ TagMap.count }.by(-1)
    end
  end
  
  describe "placeが削除された時" do
    it "tag_mapも削除" do
      expect{ place.destroy }.to change{ TagMap.count }.by(-1)
    end
  end
end
