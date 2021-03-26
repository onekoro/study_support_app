require 'rails_helper'

RSpec.feature "Places", type: :feature do
  scenario "ユーザーが新しい勉強場所を投稿する" do
    user = FactoryBot.create(:user)
    
    visit root_path
    within "header" do
      click_on "ログイン"
    end
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    
    expect{
      click_link "New"
      fill_in "店名", with: "テスト"
      fill_in "所在地", with: "東京"
      fill_in "Webページ", with: "test.com"
      fill_in "費用", with: 500
      select "あり", from: "Wifiの有無"
      select 3, from: "評価"
      fill_in "タグ入力", with: "コーヒーが美味しい 静か"
      click_button "投稿する"
      
      expect(page).to have_content "勉強場所を投稿しました"
      expect(page).to have_content "テスト"
      expect(page).to have_content "東京"
      expect(page).to have_content 500
      expect(page).to have_content "Wifiあり"
      expect(page).to have_content "コーヒーが美味しい"
      expect(page).to have_content "静か"
    }.to change(user.places, :count).by(1)
  end
end
