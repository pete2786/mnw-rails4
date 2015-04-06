class Location < ActiveRecord::Base
  scope :name_like, ->(n){ where('name like ?', "#{n}%")
                           .order("case when country='US' then '1' else 0 end desc, name, state").
                           limit(15) }
  def self.locations
    Location.all.map{|l| [l.name, l.place_id]}
  end
end
