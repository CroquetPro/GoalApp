class GoalComment < ActiveRecord::Base
  belongs_to :author,
    class_name: "User",
    foreign_key: :user_id

  belongs_to :goal
end
