require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let(:user) { create(:user) }
  let(:new_user) { build(:user) }

  scenario "新規登録に成功する" do
    visit root_path

    within "header" do
      click_link "新規登録"
    end

    aggregate_failures do
      expect {
        fill_in_new_user
        click_button "新規登録"
      }.to change(User, :count).by(1)
      expect(page).to have_content "ユーザー登録ができました"
      expect(current_path).to eq root_path
    end
  end

  scenario "新規登録に失敗する" do
    visit root_path

    within "header" do
      click_link "新規登録"
    end

    fill_in "名前", with: "aaaaa"
    fill_in "メールアドレス", with: "aaaa"
    fill_in "パスワード", with: "aaaaaa"
    fill_in "パスワード（確認）", with: "bbbbbb"
    click_button "新規登録"

    aggregate_failures do
      expect(page).to have_content "入力内容に不備があります"
    end
  end

  scenario "ユーザー情報の編集に成功する" do
    valid_login(user)

    visit user_path(user)

    click_link "プロフィール編集"

    fill_in_new_user

    click_button "更新"

    aggregate_failures do
      expect(page).to have_content "更新しました"
      expect(has_css?('.alert-success')).to be_truthy
      expect(user.reload.name).to eq new_user.name
      expect(user.reload.email).to eq new_user.email
      expect(current_path).to eq record_show_user_path(user)
    end
  end

  scenario "ユーザー情報の編集に失敗する" do
    valid_login(user)

    visit user_path(user)

    click_link "プロフィール編集"

    fill_in "名前", with: "aaaaa"
    fill_in "メールアドレス", with: "aaaa"
    fill_in "パスワード", with: "aaaaaa"
    fill_in "パスワード（確認）", with: "bbbbbb"

    click_button "更新"

    expect(page).to have_content "入力内容に不備があります"
  end

  # scenario "ユーザー情報の削除に成功する", js: true do
  #   valid_login(user)

  #   visit user_path(user)

  #   click_link "アカウント削除"

  #   expect{
  #     expect(page.accept_confirm).to eq "本当に削除しますか？"
  #     expect(page).to have_content "削除しました"
  #   }.to change(User, :count).by(-1)
  # end

  def fill_in_new_user
    fill_in "名前", with: new_user.name
    fill_in "メールアドレス", with: new_user.email
    fill_in "パスワード", with: new_user.password
    fill_in "パスワード（確認）", with: new_user.password
  end
end
