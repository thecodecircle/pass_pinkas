class MyTask < ApplicationRecord
  before_validation :default_values

  belongs_to :house
  validates  :house, presence: true

  belongs_to :task
  validates  :task, presence: true

  enum       progress: %i[in_progress done]
  validates  :progress, inclusion: { in: MyTask.progresses.keys }

  private

  def default_values
    self.progress = "in_progress" if self.progress.nil?
  end

end
