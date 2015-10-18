class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    if user.admin?
      can :manage, :all

    elsif !user.new_record?
      can :read, :all

      can :create, Phrase
      can :update, Phrase, user_id: user.id

      can :create, PhraseVote
      can :destroy, PhraseVote, user_id: user.id

      can :update, User, id: user.id

      can :destroy, SavedLocation, user_id: user.id

      can :update, Schadenfreude, user_id: user.id
      
    else # guest
      can :read, :all
    end
  end
end
