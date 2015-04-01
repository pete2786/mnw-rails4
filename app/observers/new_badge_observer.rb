class NewBadgeObserver
  def update(changed_data)
    return unless changed_data[:merit_object].is_a?(Merit::BadgesSash)

    user = User.where(sash_id: changed_data[:sash_id]).first
    badge = changed_data[:merit_object].badge
    granted_at = changed_data[:granted_at]

    BadgeMailer.earned_badge(user, badge, granted_at).deliver_now
  end
end
