class HouseUser < ApplicationRecord
    belongs_to :user
    validates  :user, presence: true

    belongs_to :house
    validates  :house, presence: true
end
