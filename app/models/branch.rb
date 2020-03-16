class Branch < ApplicationRecord
  belongs_to            :region
  validates             :region, presence: true

  has_many              :groups
  validates_associated  :groups

  validates             :name, presence: true
  validates             :score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  delegate :movement, to: :region

end
