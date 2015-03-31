class BadgeDecorator < Draper::Decorator
  delegate_all

  def title
    "#{name.capitalize}#{level_description}"
  end

  def level_description
    level.present? ? " (Level: #{level})" : ""
  end

  def image_path(suffix='')
    filename = level ? "#{name}_level#{level}" : name
    "badges/#{filename}#{suffix}.png"
  end

  def earned_on(user)
    Merit::BadgesSash.where(sash_id: user.sash_id, badge_id: id).first.try(:created_at)
  end

end
