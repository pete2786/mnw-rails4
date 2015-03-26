class ApplicationController < ActionController::Base
  layout 'application_bs'
  around_filter :set_time_zone

  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user
  end
  helper_method :current_user

  def auth_required
    # If there is a current user, check session
    if current_user
      if Time.now - Time.parse(session[:created_at]) < 2.weeks
        return true
      # Session is no longer valid, re-authentication needed.
      else
        destroy_session
        respond_to do |format|
          format.html {redirect_to '/auth/facebook', :notice => "Please login again, it has been over 2 weeks." and return false}
          format.js {render 'sessions/new', layout: false}
        end
      end
    else
      respond_to do |format|
        format.html {redirect_to '/auth/facebook', :notice => "You are required to login to complete this." and return false}
        format.js {render 'sessions/new', layout: false}
      end
    end
  end

  # Remove all traces of user session from application session cookie
  def destroy_session
    session[:user_id] = nil
    session[:token] = nil
    session[:created_at] = nil
  end

  def set_time_zone(&block)
    time_zone = current_user.try(:time_zone) || 'UTC'
    Time.use_zone(time_zone, &block)
  end
end
