class Region < ApplicationRecord
  belongs_to            :movement
  validates             :movement, presence: true

  has_many              :branches
  validates_associated  :branches

  validates             :name, presence: true
  validates             :score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
