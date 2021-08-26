require 'rails_helper'

RSpec.describe "Sessions", type: :feature do
  let(:user) { create(:user) }
  
  it "ログインが成功する" do
    valid_login(user)
    
    aggregate_failures do
      expect(page).to have_current_path root_path, ignore_query: true
      expect(page).to have_content "ログインしました"
      expect(page).to have_content "ログアウト"
      expect(page).not_to have_content "新規登録"
    end
  end
  
  it "無効な情報ではログインに失敗する" do
    visit root_path
    
    within "header" do
      click_link "ログイン"
    end
    
    click_link "ログイン"
    fill_in "メールアドレス", with: ""
    fill_in "パスワード", with: ""
    click_button "ログイン"
    
    aggregate_failures do
      expect(page).to have_current_path login_path, ignore_query: true
      expect(page).to have_content "メールアドレスまたはパスワードが異なります"
    end
  end
  
  
  it "ログアウトが成功する" do
    valid_login(user)

    click_link "ログアウト"
    
    aggregate_failures do
      expect(page).to have_current_path root_path, ignore_query: true
      expect(page).to have_content "ログアウトしました"
      expect(page).to have_content "ログイン"
      expect(page).to have_content "新規登録"
    end
  end
end
