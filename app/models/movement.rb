class Movement < ApplicationRecord
  has_many              :regions
  validates_associated  :regions

  has_many              :my_groups, as: :my_groupable
  has_many              :users, through: :my_groups, as: :my_groupable

  validates :name, presence: true, uniqueness: true

end
