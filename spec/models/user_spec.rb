require 'rails_helper'

RSpec.describe User, type: :model do
  it "名前，メール，パスワード，パスワード（確認）があれば有効" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  
  it "名前がないと無効" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end
  
  it "名前が50文字を超えたら無効" do
    user = FactoryBot.build(:user, name: "a" * 51)
    user.valid?
    expect(user.errors[:name]).to include("は50文字以内で入力してください")
  end
  
  it "メールがないと無効" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end
  
  it "メールのフォーマットが間違っていたら無効" do
    user = FactoryBot.build(:user)
    addresses = %w[user@foo..com user_at_foo,org example.user@foo.foo@bar_baz.com foo@bar+baz.com]
    addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).not_to be_valid
    end
  end
  
  it "メールアドレスが他のユーザーと同じなら無効" do
    FactoryBot.create(:user, email: "test@test.com")
    user = FactoryBot.build(:user, email: "test@test.com")
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
  
  # it "メールが250文字を超えていたら無効" do
  #   user = FactoryBot.build(:user)
  #   address = 
  #     user.email = invalid_address
  #     expect(user).not_to be_valid
  #   end
  # end
  
  it "パスワードがないと無効" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end
  
  it "パスワードが6文字未満なら無効" do
    user = FactoryBot.build(:user, password: "a" * 5)
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end
end