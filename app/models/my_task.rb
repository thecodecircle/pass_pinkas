class MyTask < ApplicationRecord
  before_validation :default_values

  belongs_to :user
  validates  :user, presence: true

  belongs_to :task
  validates  :task, presence: true

  enum       progress: %i[in_progress done approved]
  validates  :progress, inclusion: { in: MyTask.progresses.keys }

  private

  def default_values
    self.progress = "in_progress" if self.progress.nil?
  end

end
