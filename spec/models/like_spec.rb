require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { build(:like) }
  
  it "ファクトリが有効" do
    expect(like).to be_valid
  end
  
  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :place_id }
end
