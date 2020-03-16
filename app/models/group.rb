class Group < ApplicationRecord
  belongs_to            :branch
  validates             :branch, presence: true

  has_many              :my_groups, inverse_of: :user
  # validates_associated  :my_groups

  has_many              :users, through: :my_groups
  validates_associated  :users

  validates             :name, presence: true
  validates             :score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  delegate :region, to: :branch
  delegate :movement, to: :region


	def kids
	  users.where("my_groups.role = ? ", 0)
	end
end
