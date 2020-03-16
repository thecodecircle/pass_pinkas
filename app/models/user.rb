class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many              :my_groups
  validates_associated  :my_groups

  has_many              :groups, through: :my_groups
  validates_associated  :groups

  has_many              :my_tasks
  validates_associated  :my_tasks

  has_many              :tasks, through: :my_tasks
  validates_associated  :tasks

  enum role:            %i[kid group branch region movement admin], _suffix: :user
  validates :role,      inclusion: { in: User.roles.keys }
  
end
