require 'rails_helper'

RSpec.describe "Remember me", type: :request do
  let(:user) { create(:user) }
  
  context "ログイン時にRemember meを有効にしていた場合" do
    it "cookiesにremember_tokenを保存しておく" do
      post login_path, params: { session: { email: user.email, password: user.password, remember_me: '1'} }
      expect(response.cookies['remember_token']).not_to eq nil
    end
  end 

  context "ログイン時にRemember meを無効にしていた場合" do
    it "cookiesにremember_tokenが保存されない" do
      post login_path, params: { session: { email: user.email, password: user.password, remember_me: '0'} }
      expect(response.cookies['remember_token']).to eq nil
    end
  end
end
