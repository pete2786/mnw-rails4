class NewBadgeObserver
  def update(changed_data)
    return unless changed_data[:merit_object].is_a?(Merit::BadgesSash)

    NewBadgeWorker.perform_async(changed_data[:sash_id], changed_data[:merit_object].badge_id, changed_data[:granted_at])
  end
end
