require 'rails_helper'

RSpec.describe Record, type: :model do
  let(:record) { create(:record) }
  
  it "ファクトリが有効" do
    expect(record).to be_valid
  end
  
  it { is_expected.to validate_presence_of :date }
  it { is_expected.to validate_presence_of :hour }
  it { is_expected.to validate_numericality_of(:hour).only_integer }
  it { is_expected.to validate_numericality_of(:hour).is_less_than(23) }
  it { is_expected.to validate_presence_of :minute }
  it { is_expected.to validate_numericality_of(:minute).is_less_than_or_equal_to(59) }
  it { is_expected.to validate_numericality_of(:minute).only_integer }
  
  describe "userが削除された時" do
    it "recordも削除" do
      user = record.user
      expect{ user.destroy }.to change{ Record.count }.by(-1)
    end
  end
  
  describe "placeが削除された時" do
    it "recordは削除されない" do
      place = record.place
      place.destroy
      expect(Record.count).to eq 1
    end
  end
end
