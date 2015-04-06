module Api
  module V1
    class LocationsController < Api::V1::BaseController
      decorates_assigned :locations
      has_scope :name_like
      
      def index
        @locations = apply_scopes(Location).all
      end
    end
  end
end
