# Use this hook to configure merit parameters
Merit.setup do |config|
  config.checks_on_each_request = true
  config.orm = :active_record

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  config.user_model_name = 'User'
  config.current_user_method = 'current_user'
end

Merit::Badge.create!(
  id: 1,
  name: "pioneer",
  description: "One of the first 100 members"
)

Merit::Badge.create!(
  id: 2,
  name: "admin",
  description: "An admin"
)

Merit::Badge.create!(
  id: 3,
  name: "rookie",
  description: "You have submitted a phrase",
  difficulty: :bronze
)

Merit::Badge.create!(
  id: 4,
  name: "pro",
  description: "You have submitted over 10 phrases",
  difficulty: :silver
)

Merit::Badge.create!(
  id: 5,
  name: "minnesotan",
  description: "You have submitted over 50 phrases",
  difficulty: :gold
)

Merit::Badge.create!(
  id: 6,
  name: "liked",
  description: "Your phrases have over 10 likes"
)

Merit::Badge.create!(
  id: 7,
  name: "loved",
  description: "Your phrases have over 100 likes"
)

Merit::Badge.create!(
  id: 8,
  name: "revered",
  description: "Your phrases have over 1000 likes"
)

Merit::Badge.create!(
  id: 9,
  name: "meteorologist",
  description: "Sven Sundgaard. You have checked the weather.",
  level: 1
)

Merit::Badge.create!(
  id: 10,
  name: "meteorologist",
  description: "Dave Dahl. You have checked the weather 25 times.",
  level: 2
)

Merit::Badge.create!(
  id: 11,
  name: "meteorologist",
  description: "Belinda Jensen. You have checked the weather 100 times.",
  level: 3
)

Merit::Badge.create!(
  id: 12,
  name: "meteorologist",
  description: "Paul Douglas. You have checked the weather 1000 times.",
  level: 4
)

Merit::Badge.create!(
  id: 13,
  name: "judgemental",
  description: "You have voted on a phrase"
)