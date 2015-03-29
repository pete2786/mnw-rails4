class ContributionsController < ApplicationController
  def index
    @contributions = Contributions.new
  end
end
