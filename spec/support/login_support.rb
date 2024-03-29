module LoginSupport
  def valid_login(user)
    visit root_path
    within "header" do
      click_link "ログイン"
    end
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
