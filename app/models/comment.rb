class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :place
  validates :content, presence: true, length: { maximum: 400 }
  validates :recommend, presence: true
  validates :place_id, uniqueness: { scope: :user_id }
end
