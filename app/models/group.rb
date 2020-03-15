class Group < ApplicationRecord
  belongs_to :branch
  has_many :my_groups
  has_many :users, through: :my_groups
end
