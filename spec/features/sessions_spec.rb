require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  let(:user) { create(:user) }
  
  scenario "ログインが成功する" do
    valid_login(user)
    
    aggregate_failures do
      expect(current_path).to eq root_path
      expect(page).to have_content "ログインしました"
      expect(page).to have_content "ログアウト"
      expect(page).to_not have_content "新規登録"
    end
  end
  
  scenario "無効な情報ではログインに失敗する" do
    visit root_path
    
    within "header" do
      click_link "ログイン"
    end
    
    click_link "ログイン"
    fill_in "メールアドレス", with: ""
    fill_in "パスワード", with: ""
    click_button "ログイン"
    
    aggregate_failures do
      expect(current_path).to eq login_path
      expect(page).to have_content "メールアドレスまたはパスワードが異なります"
    end
  end
  
  
  scenario "ログアウトが成功する" do
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
