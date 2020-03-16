class Task < ApplicationRecord
  has_many :my_tasks
  validates_associated  :my_tasks

  has_many :users, through: :my_tasks
  validates_associated  :users

  enum publicity: %i[personal general]
  validates  :publicity, inclusion: { in: Task.publicities.keys }

  enum status: %i[unapproved approved]
  validates  :status, inclusion: { in: Task.statuses.keys }

  validates             :name, presence: true
  validates             :description, presence: true
  validates             :score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
