class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :place
  validates :content, presence: true
  validates :recommend, presence: true
end
