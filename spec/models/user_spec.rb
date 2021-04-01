require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }
  
  it "ファクトリが有効" do
    expect(user).to be_valid
  end
  
  # 名前，メール，パスワードがないと無効
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_length_of(:name).is_at_most(50) }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_length_of(:email).is_at_most(250) }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }
  
  it "メールアドレスが他のユーザーと同じなら無効" do
    FactoryBot.create(:user, email: "test@test.com")
    user.email = "test@test.com"
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
  
  describe "メールアドレスのフォーマットが" do
    it "無効の場合" do
      addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid
      end
    end
    
    it "有効の場合" do
      valid_addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
  end
  
  describe "パスワード確認が" do
    it "一致する場合" do
      user.password_confirmation = "password"
      expect(user).to be_valid
    end
    
    it "一致しない場合" do
      user.password_confirmation = "different"
      expect(user).not_to be_valid
    end
  end
  
end