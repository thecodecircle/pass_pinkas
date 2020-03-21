class Branch < ApplicationRecord
  belongs_to            :region
  validates             :region, presence: true

  has_many              :groups, dependent: :destroy
  validates_associated  :groups

  has_many              :my_groups, as: :my_groupable, dependent: :destroy
  has_many              :users, through: :my_groups, as: :my_groupable, dependent: :destroy

  validates             :name, presence: true
  validates             :score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  delegate :movement, to: :region


	def kids
		groups.map{ |g| g.kids.where("my_groups.role = ? ", 0) }.flatten
		# .where("my_groups.role = ? ", 0)
		# .users.where("my_groups.role = ? ", 0)
	end
end
