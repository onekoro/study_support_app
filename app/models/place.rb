class Place < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :good_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 20 }
  validates :address, presence: true, length: { maximum: 100 }
  validates :cost, presence: true
  validates :wifi, presence: true
  validates :recommend, presence: true
  validates :content, length: { maximum: 400 }
  mount_uploader :image, ImageUploader
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  
  # 投稿をいいねする
  def good(user)
    likes.create(user_id: user.id)
  end

  # 投稿のいいねを解除する
  def ungood(user)
    likes.find_by(user_id: user.id).destroy
  end
  
  # 現在のユーザーがいいねしてたらtrueを返す
  def good?(user)
    good_users.include?(user)
  end
end
