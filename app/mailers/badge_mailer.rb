class BadgeMailer < ApplicationMailer
  def earned_badge(user, badge, granted_at)
    @user = UserDecorator.new(user)
    @badge = BadgeDecorator.new(badge)
    @granted_at = granted_at
    mail(to: @user.email, subject: "You have earned a badge on Weather Clever")
  end
end
