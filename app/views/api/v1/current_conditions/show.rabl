object current_condition

attribute :id
attribute :location
attribute :temperature
attribute :description
attribute :lat
attribute :long
attribute :url

child :phrase do
  attribute :phrase
  attribute :image
end
