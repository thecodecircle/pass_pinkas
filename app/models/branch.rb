class Branch < ApplicationRecord
  belongs_to :region
  has_many :groups
end
