class Record < ApplicationRecord
  belongs_to :user
  belongs_to :place, optional: true
  validates :date, presence: true
  validates :hour, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 23 }
  validates :minute, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 59 }
end
