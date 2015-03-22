# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+votes: 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badge (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badge to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badge is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      # Condition badges
      grant_on 'current_conditions#create', badge: 'meteorologist', level: 1 do |current_condition|
        current_condition.user && current_condition.user.current_conditions.count == 1
      end

      grant_on 'current_conditions#create', badge: 'meteorologist', level: 2 do |current_condition|
        current_condition.user && current_condition.user.current_conditions.count == 25
      end

      grant_on 'current_conditions#create', badge: 'meteorologist', level: 3 do |current_condition|
        current_condition.user && current_condition.user.current_conditions.count == 100
      end

      grant_on 'current_conditions#create', badge: 'meteorologist', level: 4 do |current_condition|
        current_condition.user && current_condition.user.current_conditions.count == 1000
      end

      # Phrase badges
      grant_on 'phrases#create', badge: 'rookie', temporary: true do |phrase|
        phrase.user.phrases.count > 0 && phrase.user.phrases.count <= 10
      end

      grant_on 'phrases#create', badge: 'pro', temporary: true do |phrase|
        phrase.user.phrases.count > 10 && phrase.user.phrases.count <= 50
      end

      grant_on 'phrases#create', badge: 'minnesotan' do |phrase|
        phrase.user.phrases.count > 50
      end

      # Phrase vote
      grant_on 'phrase_votes#create', badge: 'judgemental'

      grant_on 'phrase_votes#create', badge: 'liked', to: :phrase_user do |vote|
        vote.phrase_user.phrase_vote_rep > 10
      end

      grant_on 'phrase_votes#create', badge: 'loved', to: :phrase_user do |vote|
        vote.phrase_user.phrase_vote_rep > 100
      end

      grant_on 'phrase_votes#create', badge: 'revered', to: :phrase_user do |vote|
        vote.phrase_user.phrase_vote_rep > 1000
      end

      # grant_on 'registrations#update', badge: 'autobiographer',
      #   temporary: true, model_name: 'User' do |user|
      #
      #   user.name.length > 4
      # end
    end
  end
end
