class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  has_many :places, through: :tag_maps
  validates :tag_name, presence: true, length: { maximum: 20 }
end
