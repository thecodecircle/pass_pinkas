class MyGroup < ApplicationRecord
  belongs_to :user
  validates  :user, presence: true

  belongs_to :group
  validates  :group, presence: true

  enum role: %i[kid guide]
  # validates :role, inclusion: { in: MyGroup.roles.keys }

end
