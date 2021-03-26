require 'rails_helper'

RSpec.describe Place, type: :model do
  it "generates associated data from a factory" do
    place = FactoryBot.create(:place)
    puts "title: #{place.title}"
    puts "address: #{place.address}"
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