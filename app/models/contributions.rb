class Contributions
  def top_phrases
    Phrase.top(10)
  end

  def top_users
    User.top(10)
  end
end
