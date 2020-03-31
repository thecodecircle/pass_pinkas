class House < ApplicationRecord
  belongs_to            :family
  validates             :family, presence: true

  # validates_associated  :my_groups
  has_many              :house_users
  has_many              :users, through: :house_users, dependent: :destroy
  has_many              :tasks, through: :users
  # validates_associated  :users

  validates             :name, presence: true
  validates             :score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }


end
