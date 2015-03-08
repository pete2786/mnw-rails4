class SessionsController < ApplicationController
  def create 
    @user = ProviderUser.new(request.env["omniauth.auth"]).create_or_update
    create_session
    redirect_to request.env['omniauth.origin'] || root_path
  end

  def new

  end

  def destroy
    destroy_session
    redirect_to root_url, :notice => "Signed out!"
  end

  def create_session
    session[:user_id] = @user.id
    session[:token] = @user.token
    session[:created_at] = Time.now
  end
  private :create_session
end
