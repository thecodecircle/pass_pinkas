class Region < ApplicationRecord
  belongs_to :movement
  has_many :branches
end
