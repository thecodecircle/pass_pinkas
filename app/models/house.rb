class House < ApplicationRecord
  belongs_to            :family
  validates             :family, presence: true

  has_many              :house_users
  has_many              :users, through: :house_users, dependent: :destroy
  has_many              :my_tasks
  has_many              :tasks, through: :my_tasks

  validates             :name, presence: true
  validates             :score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }


end
