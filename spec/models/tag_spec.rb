require 'rails_helper'

RSpec.describe Tag, type: :model do
  let!(:tag) { create(:tag) }
  let!(:place) { create(:place) }
  let!(:tag_map){ create(:tag_map, place: place, tag: tag) }
  
  it "ファクトリが有効" do
    expect(tag).to be_valid
  end
  
  it { is_expected.to validate_presence_of :tag_name }
  it { is_expected.to validate_length_of(:tag_name).is_at_most(20) }
  
end
