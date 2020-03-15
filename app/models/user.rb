class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :my_groups
  has_many :groups, through: :my_groups
  has_many :my_tasks
  has_many :tasks, through: :my_tasks
  enum role: [ :kid, :group, :branch, :region, :movement, :admin ], _suffix: :user
end
