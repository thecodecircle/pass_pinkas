class MyTask < ApplicationRecord
  belongs_to :user
  belongs_to :task
  enum progress: [ :in_progress, :done, :approved ]
end
