# Study Support
勉強できる場所を探すアプリです．
また，勉強場所を含めた学習内容を記録する機能などが実装されています．
URL: https://study-support-app.com/
<img width="1435" alt="スクリーンショット 2021-07-29 16 46 56" src="https://user-images.githubusercontent.com/64568034/127453123-46b62eb2-cecc-48b5-8ece-8618eb63b1e5.png">

## 使用技術
* フロントエンド
  * HTML/CSS
  * Javascript
* バックエンド
  * Ruby 2.6.3
  * Ruby on Rails 6.1.3
  * Rspec(テスト)
* インフラ
  * PostgreSQL 13.3
  * AWS
    * VPC
    * EC2
    * S3
    * ACM
    * ALB
    * CloudFront
    * Route53
    * RDS
  * Puma

## 機能一覧
* ユーザー登録
* ログイン機能
* 投稿機能
  * 画像投稿(carrierwave, mini_magick)
  * 位置情報表示(Google Maps API, geocoder)
* いいね機能(Ajax)
* コメント機能
* フォロー機能(Ajax)
* ページネーション機能(kaminari)
* 検索機能(ransack)
* 学習時間表示機能(chartkick)
