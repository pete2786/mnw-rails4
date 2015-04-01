class NewBadgeWorker
  include Sidekiq::Worker

  def perform(sash_id, badge_id, granted_at)
    user = User.where(sash_id: sash_id).first
    badge = Merit::Badge.find(badge_id)
    granted_at = granted_at

    BadgeMailer.earned_badge(user, badge, granted_at).deliver_now
    puts "bout to email a dude"
  end
end
