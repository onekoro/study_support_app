require 'rails_helper'

RSpec.describe Place, type: :model do
  let(:place) { create(:place) }
  
  it "ファクトリが有効" do
    expect(place).to be_valid
  end
  
    # タイトル，住所，費用，wifiの有無，おすすめ度がないと無効
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_length_of(:title).is_at_most(20) }
  it { is_expected.to validate_presence_of :address }
  it { is_expected.to validate_length_of(:address).is_at_most(100) }
  it { is_expected.to validate_presence_of :cost }
  it { is_expected.to validate_presence_of :wifi }
  it { is_expected.to validate_presence_of :recommend }
  it { is_expected.to validate_length_of(:content).is_at_most(400) }

  describe "userが削除された時" do
    it "placeも削除" do
      user = place.user
      expect{ user.destroy }.to change{ Place.count }.by(-1)
    end
  end
      

end