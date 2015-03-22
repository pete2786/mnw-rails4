class ContributionsController < ApplicationController
  before_filter :auth_required

  def index
    @contributions = Contributions.new
  end
end
