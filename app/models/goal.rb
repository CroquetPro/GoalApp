class Goal < ActiveRecord::Base
  belongs_to :user

  validates :title, :user_id, :privacy, :status, presence: true
  validates :privacy, inclusion: %w(Public Private)
  validates :status, inclusion: %w(Incomplete Complete)
end
