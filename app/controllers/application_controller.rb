class ApplicationController < ActionController::Base
  layout 'application_bs'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
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
      if Time.now - Time.parse(session[:created_at]) < 1440.minutes
        return true
      # Session is no longer valid, re-authentication needed.
      else
        destroy_session
        respond_to do |format|
          format.html {redirect_to '/auth/facebook', :notice => "Your session has timed out. Please re-authenticate." and return false}
          format.js {render 'sessions/new', layout: false}
        end
      end
    else
      respond_to do |format|
        format.html {redirect_to '/auth/facebook', :notice => "Your session has timed out. Please re-authenticate." and return false}
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
end
