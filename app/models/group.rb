class Group < ApplicationRecord
  belongs_to            :branch
  validates             :branch, presence: true

  has_many              :my_groups
  validates_associated  :my_groups

  has_many              :users, through: :my_groups
  validates_associated  :users

  validates             :name, presence: true
  validates             :score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
end
