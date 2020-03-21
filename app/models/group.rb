class Group < ApplicationRecord
  belongs_to            :branch
  validates             :branch, presence: true

  # validates_associated  :my_groups

  has_many              :my_groups, as: :my_groupable, dependent: :destroy
  has_many              :users, through: :my_groups, as: :my_groupable, dependent: :destroy
  # validates_associated  :users

  validates             :name, presence: true
  validates             :score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  delegate :region, to: :branch
  delegate :movement, to: :region


	def kids
	  users.where("my_groups.role = ? ", 0)
	end
end
