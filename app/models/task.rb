class Task < ApplicationRecord
  has_many :my_tasks
  has_many :users, through: :my_tasks
  enum privacy: [ :personal, :general ]
  enum status: [ :not_approved, :approved ]
end
