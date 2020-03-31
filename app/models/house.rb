class House < ApplicationRecord
  belongs_to            :family
  validates             :family, presence: true

  # validates_associated  :my_groups

  has_many tasks through: users
  has_many              :users, through: :house_users, dependent: :destroy
  # validates_associated  :users

  validates             :name, presence: true
  validates             :score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }


end
