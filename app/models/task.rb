class Task < ApplicationRecord
  has_many :my_tasks
  has_many :users, through: :my_tasks
  enum privacy: [ :private, :public ]
  enum status: [ :not_approved, :approved ]
end
