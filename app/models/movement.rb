class Movement < ApplicationRecord
  has_many              :regions, dependent: :destroy
  validates_associated  :regions

  has_many              :my_groups, as: :my_groupable, dependent: :destroy
  has_many              :users, through: :my_groups, as: :my_groupable, dependent: :destroy

  validates :name, presence: true, uniqueness: true

end
