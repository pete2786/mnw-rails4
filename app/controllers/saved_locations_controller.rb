class SavedLocationsController < ApplicationController
  before_filter :auth_required
  load_and_authorize_resource

  def destroy
    @saved_location.destroy
    redirect_to user_path(@saved_location.user)
  end
end
