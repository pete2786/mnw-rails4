class UserDecorator < Draper::Decorator
  decorates_finders
  delegate_all
  decorates_association :badges, with: BadgeDecorator

  def badges_per_row(n)
    badge_array = []
    badges.each_with_index do |b, i|
      badge_array << b
      if badge_array.length == n || (i+1) == badges.count
        yield(badge_array)
        badge_array = []
      end
    end
  end
end
