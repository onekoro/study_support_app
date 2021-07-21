# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

User.create!(name:  "ゲスト",
             email: "guest@example.com",
             password: "guestguest",
             password_confirmation: "guestguest",
             admin: false)

User.create!(name:  "Example User",
             email: "example@example.org",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true)

# 追加のユーザーをまとめて生成する
60.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password#{n}"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# ユーザーの一部を対象に投稿を生成する
users = User.order(:created_at).take(50)
10.times do |n|
  users.each do |user|
    title = Faker::Lorem.word
    content = Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4)
    image = "default_place.jpg"
    address = Gimei.address.kanji
    web = Faker::Internet.url
    cost = Faker::Number.between(from: 0, to: 10000)
    if n%2 == 0
      wifi = "あり"
    else
      wifi = "なし"
    end
    recommend = Faker::Number.within(range: 1..5)
    user.places.create!(title: title, content: content, image: image, address: address, web: web, cost: cost, wifi: wifi, recommend: recommend)
  end
end

# ユーザーの一部を対象に学習記録を生成する
10.times do |n|
  date = Date.today-n
  hour = Faker::Number.between(from: 0, to: 10)
  minute = Faker::Number.between(from: 1, to: 59)
  place_id = n+1
  content = Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4)
  users.each { |user| user.records.create!(date: date, hour: hour, minute: minute, place_id: place_id, content: content) }
end

# 以下のリレーションシップを作成する
user1 = users.first
following = users[2..40]
followers = users[3..40]
following.each { |followed| user1.follow(followed) }
followers.each { |follower| follower.follow(user1) }

places = Place.order(:created_at).take(10)
# 投稿にいいねする
10.times do |n|
  user = User.find(n+1)
  places.each { |place| place.good(user) }
end

# 投稿にコメントする
5.times do |n|
  user = User.find(n+1)
  recommend = Faker::Number.within(range: 1..5)
  content = Faker::Lorem.sentence
  places.each { |place| place.comments.create!(recommend: recommend, content: content, user_id: user.id) }
end

# タグの生成
10.times do |n|
  Tag.create(tag_name: Faker::Lorem.word)
end
# タグと場所の関連づけ
5.times do |n|
  places.each { |place| TagMap.create(tag_id: n+1, place_id: place.id) }
end
