# Study Support
## アプリの概要
外の作業や勉強のサポートをするアプリです．  
検索機能から学習場所を探したり，自分が行った学習内容を記録することができます．  
公式マニュアル、技術記事を参考に全て独学で開発しました．  
URL: https://study-support-app.com/  
<img width="1435" alt="スクリーンショット 2021-07-29 16 46 56" src="https://user-images.githubusercontent.com/64568034/127453123-46b62eb2-cecc-48b5-8ece-8618eb63b1e5.png">

## 使用技術
### フロントエンド
  * HTML/CSS
  * Javascript
### バックエンド
  * Ruby 2.6.3
  * Ruby on Rails 6.1.3
### インフラ
  * PostgreSQL 13.3
  * AWS（VPC、EC2, S3, ACM, ALB, CloudFront, Route53, RDS)
  * Docker / Docker-compose
  * CircleCI(CI/CD)
  * Puma
### テスト
  * Rspec
  * Rubocop

## インフラ構成
<img width="593" alt="スクリーンショット 2021-09-21 22 55 51" src="https://user-images.githubusercontent.com/64568034/134184557-c9315869-a0ee-4aec-8ec2-dc49597f9756.png">


## ER図
<img width="635" alt="スクリーンショット 2021-09-19 21 58 03" src="https://user-images.githubusercontent.com/64568034/133928530-41ff5ec9-f407-42a0-8319-6cf230f68d42.png">


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
