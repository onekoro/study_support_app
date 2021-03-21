# Study Spot Serch
勉強できる場所を探すアプリです．
<img width="1434" alt="スクリーンショット 2021-03-19 17 12 45" src="https://user-images.githubusercontent.com/64568034/111899527-7a6f0b00-8a70-11eb-9a12-0b3ec71c258f.png">

# 使用技術
* Ruby 2.6.3
* Ruby on Rails 6.0.3
* SQLite 3.22.0
* AWS
  * EC2
* Google Maps API

# 機能一覧
* ユーザー登録
* ログイン機能
* 投稿機能
  * 画像投稿(carrierwave, mini_magick)
  * 位置情報表示(geocoder)
* いいね機能(Ajax)
* コメント機能
* フォロー機能(Ajax)
* ページネーション機能(kaminari)
* 検索機能(ransack)