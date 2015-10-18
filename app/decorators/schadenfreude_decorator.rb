class SchadenfreudeDecorator < Draper::Decorator
  decorates_finders
  delegate_all

  decorates_association :my_current_condition, with: CurrentConditionDecorator
  decorates_association :their_current_condition, with: CurrentConditionDecorator

end
