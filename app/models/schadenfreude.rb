class Schadenfreude < ActiveRecord::Base
  belongs_to :my_current_condition, class_name: :CurrentCondition, foreign_key: "my_current_condition_id"
  belongs_to :their_current_condition, class_name: :CurrentCondition, foreign_key: "their_current_condition_id"
  belongs_to :user

end
