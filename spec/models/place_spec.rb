require 'rails_helper'

RSpec.describe Place, type: :model do
  let(:place) { create(:place) }
  
  it "ファクトリが有効" do
    expect(place).to be_valid
  end
  
    # タイトル，住所，費用，wifiの有無，おすすめ度がないと無効
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_length_of(:title).is_at_most(20) }
  it { is_expected.to validate_presence_of :address }
  it { is_expected.to validate_length_of(:address).is_at_most(100) }
  it { is_expected.to validate_presence_of :cost }
  it { is_expected.to validate_presence_of :wifi }
  it { is_expected.to validate_presence_of :recommend }
  it { is_expected.to validate_length_of(:content).is_at_most(400) }

  describe "ユーザーが削除された時" do
    it "succeeds" do
      user = place.user
      expect{ user.destroy }.to change{ Place.count }.by(-1)
    end
  end
      
      
#   it "returns places that match the search term" do
#     user = User.create(
#       name: "test",
#       email: "test@test.com",
#       password: "password",
#       password_confirmation: "password"
#     )
    
#     place1 = user.places.create(
#       title: "喫茶店",
#       address: "東京都",
#       cost: "500",
#       wifi: "あり",
#       recommend: "3",
#       content: "test"
#     )
    
#     place2 = user.places.create(
#       title: "図書館",
#       address: "東京都",
#       cost: "500",
#       wifi: "あり",
#       recommend: "3",
#       content: "test"
#     )
    
#     place3 = user.places.create(
#       title: "喫茶店",
#       address: "神奈川県",
#       cost: "500",
#       wifi: "あり",
#       recommend: "3",
#       content: "test"
#     )
    
#     place4 = user.places.create(
#       title: "喫茶店",
#       address: "東京都",
#       cost: "500",
#       wifi: "あり",
#       recommend: "3",
#       content: "aaa"
#     )
    
#     expect(Place.search("喫茶店")).to include(place1, place3, place4)
#     expect(Place.search("喫茶店")).to_not include(place2)
    
#     expect(Place.search("東京都")).to include(place1, place2, place4)
#     expect(Place.search("東京都")).to_not include(place3)
    
#     expect(Place.search("test")).to include(place1, place2, place3)
#     expect(Place.search("test")).to_not include(place4)
#   end
end