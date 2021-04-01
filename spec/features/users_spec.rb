require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario "新規登録に成功する" do
    user = FactoryBot.build(:user)
    
    visit root_path
    
    within "header" do
      click_link "新規登録"
    end
    
    aggregate_failures do
      expect {
        fill_in "名前", with: user.name
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        fill_in "パスワード（確認）", with: user.password
        click_button "新規登録"
      }.to change(User, :count).by(1)
      
      expect(page).to have_content "ユーザー登録ができました"
      expect(current_path).to eq root_path
    end
  end
  
  scenario "ログインが成功する" do
    user = FactoryBot.create(:user)
    
    valid_login(user)
    
    aggregate_failures do
      expect(current_path).to eq root_path
      expect(page).to have_content "ログインしました"
      expect(page).to have_content "ログアウト"
      expect(page).to_not have_content "新規登録"
    end
  end
  
  scenario "ログアウトが成功する" do
    user = FactoryBot.create(:user)
    
    valid_login(user)

    click_link "ログアウト"
    
    aggregate_failures do
      expect(current_path).to eq root_path
      expect(page).to have_content "ログアウトしました"
      expect(page).to have_content "ログイン"
      expect(page).to have_content "新規登録"
    end
  end
end
