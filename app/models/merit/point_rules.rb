# Be sure to restart your server when you modify this file.
#
# Points are a simple integer value which are given to "meritable" resources
# according to rules in +app/models/merit/point_rules.rb+. They are given on
# actions-triggered, either to the action user or to the method (or array of
# methods) defined in the +:to+ option.
#
# 'score' method may accept a block which evaluates to boolean
# (recieves the object as parameter)

module Merit
  class PointRules
    include Merit::PointRulesMethods

    def initialize
      #score 10, :on => 'phrases#create', to: :user
      #score -10, :on => 'phrases#destroy', to: :user

      #score 1, :on => 'phrase_votes#create', to: :user
      #score 5, :on => 'phrase_votes#create', to: :phrase_user
    end
  end
end
