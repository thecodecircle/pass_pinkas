class Region < ApplicationRecord
  belongs_to            :movement
  validates             :movement, presence: true

  has_many              :branches
  validates_associated  :branches

  has_many              :my_groups, as: :my_groupable
  has_many              :users, through: :my_groups, as: :my_groupable

  validates             :name, presence: true
  validates             :score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
