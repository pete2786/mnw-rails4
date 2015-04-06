class SavedLocation < ActiveRecord::Base
  belongs_to :user

  scope :geo, ->(lat, long){ where(lat: lat, long: long)}
  scope :loc_name, ->(n){ where(name: n)}

  def self.saved?(current_condition)
    SavedLocation.loc_name(current_condition.location).exists? || 
    SavedLocation.geo(current_condition.lat, current_condition.long).exists?
  end
end
