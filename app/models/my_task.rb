class MyTask < ApplicationRecord
  belongs_to :user
  validates  :user, presence: true

  belongs_to :task
  validates  :task, presence: true

  enum       progress: %i[in_progress done approved]
  validates  :progress, inclusion: { in: MyTask.progresses.keys }

end
