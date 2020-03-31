class Family < ApplicationRecord

  has_many              :houses, dependent: :destroy
  validates_associated  :houses

  has_many              :users, through: :houses, as: :my_houseable, dependent: :destroy
  has_many              :tasks, through: :users

  validates             :name, presence: true
  validates             :score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }


end
