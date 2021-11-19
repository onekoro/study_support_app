# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

# ユーザー生成
User.create!(name:  "ゲスト",
             email: "guest@example.com",
             password: "guestguest",
             password_confirmation: "guestguest",
            #  image: File.open("#{Rails.root}/app/javascript/images/default_user_image_1.jpg"),
             admin: false)

User.create!(name:  "テストユーザー1",
             email: "example1@example.org",
             password: "testtest1",
             password_confirmation: "testtest1",
            #  image: File.open("#{Rails.root}/app/javascript/images/default_user_image_2.jpg"),
             admin: false)

User.create!(name:  "テストユーザー2",
             email: "example2@example.org",
             password: "testtest2",
             password_confirmation: "testtest2",
            #  image:File.open("#{Rails.root}/app/javascript/images/default_user_image_3.jpg"),
             admin: true)

20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password#{n}"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# ユーザーの一部を対象に投稿を生成する
place1 = Place.create(title: "世田谷区立図書館",
              content: "静かで集中できた．毎月第二木曜日は休館日なので注意",
              # image: File.open("#{Rails.root}/app/javascript/images/default_place_image_1.jpg"),
              address: "東京都世田谷区祖師谷３丁目１０−４",
              web: "https://libweb.city.setagaya.tokyo.jp/main/list_00204info.shtml",
              cost: 0,
              wifi: "なし",
              recommend: 4,
              user: User.first)

place2 = Place.create(title: "ドトール祖師谷大倉店",
              content: "長時間滞在はできない.wifiがないためPC作業には向かない",
              # image: File.open("#{Rails.root}/app/javascript/images/default_place_image_2.jpg"),
              address: "東京都世田谷区祖師谷1‐7‐1",
              web: "https://shop.doutor.co.jp/map/1011862",
              cost: 300,
              wifi: "なし",
              recommend: 2,
              user: User.first)

place3 = Place.create(title: "快活CLUB下北沢店",
              content: "完全個室，電源あり，ソフトドリンク飲み放題とサービスが充実している．",
              # image: File.open("#{Rails.root}/app/javascript/images/default_place_image_3.jpg"),
              address: "東京都世田谷区北沢2-4-5",
              web: "https://www.kaikatsu.jp/shop/detail/20912.html",
              cost: 1500,
              wifi: "あり",
              recommend: 5,
              user: User.first)

users = User.order(:created_at).take(10)
count = 1
2.times do |n|
  users.each do |user|
    if count%3 == 0
      title = "喫茶店" + (count/3+1).to_s
    elsif count%3 == 1
      title = "図書館" + (count/3+1).to_s
    elsif count%3 == 2
      title = "自習室" + (count/3+1).to_s
    end
    content = "これはテストです"
    image = "default_place.jpg"
    address = Gimei.address.kanji
    web = Faker::Internet.url
    cost = rand(0..10000)
    wifi = ["あり", "なし"].sample
    recommend = rand(1..5)
    user.places.create!(title: title, content: content, image: image, address: address, web: web, cost: cost, wifi: wifi, recommend: recommend)
    count += 1
  end
end

# ユーザーの一部を対象に学習記録を生成する
10.times do |n|
  date = Date.today-n
  hour = rand(0..10)
  minute = rand(1..59)
  place_id = n+1
  content = ["捗った", "あまり集中できなかった", "実験レポートを書いた", "参考書のp.32~45をやった"].sample
  users.each { |user| user.records.create!(date: date, hour: hour, minute: minute, place_id: place_id, content: content) }
end

# 以下のリレーションシップを作成する
user1 = users.first
following = users[2..20]
followers = users[3..20]
following.each { |followed| user1.follow(followed) }
followers.each { |follower| follower.follow(user1) }

places = Place.order(:created_at).take(10)
# 投稿にいいねする
places.each do |place|
  like_users = User.all.sample(rand(1..17))
  like_users.each { |user| place.good(user) }
end

like_users = User.all.sample(18)
like_users.each { |user| place1.good(user) }

like_users = User.all.sample(19)
like_users.each { |user| place2.good(user) }

like_users = User.all
like_users.each { |user| place3.good(user) }

# 10.times do |n|
#   user = User.find(n+1)
#   places.each { |place| place.good(user) }
# end

# 投稿にコメントする
5.times do |n|
  user = User.find(n+1)
  recommend = rand(1..5)
  content = Faker::Lorem.sentence
  places.each { |place| place.comments.create!(recommend: recommend, content: content, user_id: user.id) }
  place1.comments.create!(recommend: recommend, content: content, user_id: user.id)
  place2.comments.create!(recommend: recommend, content: content, user_id: user.id)
  place3.comments.create!(recommend: recommend, content: content, user_id: user.id)
end

# タグの生成
tag_name = ["個室", "コンセントあり", "駅近", "会話OK", "24時間開放", "長期滞在可能", "会話NG", "PCあり", "喫茶店", "図書館", "自習室"]
tag_name.each do |name|
  Tag.create(tag_name: name)
end

# タグと場所の関連づけ
places.each do |place|
  place_tags = Tag.all.sample(rand(1..5))
  place_tags.each { |tag| TagMap.create(tag_id: tag.id, place_id: place.id)}
end

place_tags = Tag.all.sample(rand(1..5))
place_tags.each { |tag| TagMap.create(tag_id: tag.id, place_id: place1.id)}
place_tags = Tag.all.sample(rand(1..5))
place_tags.each { |tag| TagMap.create(tag_id: tag.id, place_id: place2.id)}
place_tags = Tag.all.sample(rand(1..5))
place_tags.each { |tag| TagMap.create(tag_id: tag.id, place_id: place3.id)}
