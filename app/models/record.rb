class Record < ApplicationRecord
  belongs_to :user
  belongs_to :place
  validates :date, presence: true
  validates :hour, presence: true, numericality: { less_than_or_equal_to: 24 }
  validates :minute, presence: true, numericality: { less_than_or_equal_to: 59 }
end
