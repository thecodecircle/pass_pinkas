class Branch < ApplicationRecord
  belongs_to            :region
  validates             :region, presence: true

  has_many              :groups
  validates_associated  :groups

  has_many              :my_groups, as: :my_groupable
  has_many              :users, through: :my_groups, as: :my_groupable

  validates             :name, presence: true
  validates             :score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  delegate :movement, to: :region

end
