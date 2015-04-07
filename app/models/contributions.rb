class Contributions
  def top_phrases
    Phrase.complete.top.limit(10)
  end

  def top_users
    User.top(10)
  end

  def top_contributers
    User.top_contributers(10)
  end

end
