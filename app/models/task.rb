class Task < ApplicationRecord
  before_validation :set_score

  has_many :my_tasks
  validates_associated  :my_tasks

  has_many :users, through: :my_tasks
  validates_associated  :users

  enum publicity: %i[personal general]
  validates  :publicity, inclusion: { in: Task.publicities.keys }

  enum status: %i[unapproved approved]
  validates  :status, inclusion: { in: Task.statuses.keys }

  enum difficulty: %i[easy medium hard impossible]
  validates  :difficulty, inclusion: { in: Task.difficulties.keys }

  validates             :name, presence: true
  validates             :description, presence: true
  validates             :score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def set_score
    puts "****************************************"
    score_hash = {
      easy: 10,
      medium: 50,
      hard: 100,
      impossible: 300
    }
    puts score_hash[self.difficulty.to_sym]
    self.score = score_hash[self.difficulty.to_sym]
    puts "Score: #{self.score}"
  end
  
end
