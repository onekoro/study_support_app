# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
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
  title = "タイトル#{n}"
  content = Faker::String.random(length: 100..300)
  image = "default_place.jpg"
  adress = Faker::Address.full_address
  web = Faker::Internet.url
  cost = Faker::Number.number(digits: 3)
  wifi = "あり"
  recommend = n
  users.each { |user| user.places.create!(title: title, content: content, image: image, adress: adress, web: web, cost: cost, wifi: wifi, recommend: recommend) }
end

# 以下のリレーションシップを作成する
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
