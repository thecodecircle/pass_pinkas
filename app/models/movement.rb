class Movement < ApplicationRecord
  has_many :regions
  validates_associated :regions

  validates :name, presence: true, uniqueness: true
  
end
