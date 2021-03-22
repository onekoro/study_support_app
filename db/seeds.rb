# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# ユーザーの一部を対象にマイクロポストを生成する
users = User.order(:created_at).take(10)
5.times do |n|
  # title = Faker::String.random(length: 5..20)
  title = "test"
  # content = Faker::String.random(length: 100..400)
  content = "test"
  image = "default_place.jpg"
  # address = Faker::Address.full_address
  address = "東京"
  # web = Faker::Internet.url
  web = "test"
  cost = Faker::Number.between(from: 100, to: 10000)
  if n%2 == 0
    wifi = "あり"
  else
    wifi = "なし"
  end
  recommend = n
  users.each { |user| user.places.create!(title: title, content: content, image: image, address: address, web: web, cost: cost, wifi: wifi, recommend: recommend) }
end

# 以下のリレーションシップを作成する
users = User.all
user1 = users.first
user2 = users.second
following = users[2..50]
followers = users[3..40]
following.each { |followed| user1.follow(followed) }
followers.each { |follower| follower.follow(user1) }

places1 = user1.places
places1.each { |place1| place1.good(user2) }
places2 = user2.places
places2.each { |place2| place2.good(user1) }



