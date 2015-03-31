class BadgesController < ApplicationController
  layout false
  before_filter :find_user
  before_filter :check_user_badge

  def find_user
    @user = UserDecorator.find(params[:user_id])
    @badge = BadgeDecorator.new(@user.find_badge(params[:id].to_i))
  end

  def check_user_badge
    redirect_to user_path(@user) unless @user.has_badge?(params[:id].to_i)
  end

  def determine
    params.keys.include?("modal") ?  false : 'application_bs'
  end
end
