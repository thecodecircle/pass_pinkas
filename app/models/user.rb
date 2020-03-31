class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many              :house_users
  has_many              :houses, through: :house_users, dependent: :destroy
  has_many              :families, through: :houses

  # has_many              :houses, through: :my_houses
  # has_many              :my_houses
  # has_many              :my_houseables, through: :my_houses
  # has_many              :houses, through: :my_houses, source: :my_houseable, source_type: "House"
  # has_many              :families, through: :my_houses, source: :my_houseable, source_type: "Family"
  # has_many              :regions, through: :my_houses, source: :my_houseable, source_type: "Region"
  # has_many              :movements, through: :my_houses, source: :my_houseable, source_type: "Movement"
  has_many              :my_tasks
  # has_many              :my_tasks, inverse_of: :my_tasks
  has_many              :tasks, through: :my_tasks

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

	def is_guide(houseable)
	  if my_houses.find_by(my_houseable_id: houseable.id, my_houseable_type: houseable.class.name).role == "guide"
			return true
		else
			return false
		end
	end

	def role
    return "Admin" if my_houses.empty?
		return "Movement" if my_houses.pluck(:my_houseable_type).uniq.include?("Movement")
		return "Region" if my_houses.pluck(:my_houseable_type).uniq.include?("Region")
		return "Family" if my_houses.pluck(:my_houseable_type).uniq.include?("Family")
		if houses.map {|g| is_guide(g)}.include?(true)
			return "House" if my_houses.pluck(:my_houseable_type).uniq.include?("House")
		else
			return "Kid"
		end
	end
end
