class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many              :my_groups, inverse_of: :user
  has_many              :groups, through: :my_groups
  has_many              :my_tasks
  # has_many              :my_tasks, inverse_of: :my_tasks
  has_many              :tasks, through: :my_tasks

  enum role:            %i[kid group branch region movement admin], _suffix: :user
  validates :role,      inclusion: { in: User.roles.keys }
  validates :username, presence: :true, uniqueness: { case_sensitive: false }

  def email_required?
    false
  end

  def email_changed?
    false
  end

  attr_writer :login

  def login
    @login || self.username || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
    end

end
