module Api
  module V1
    class LocationsController < Api::V1::BaseController
      decorates_assigned :locations
      has_scope :name_like
      
      def index
        @locations = min_name_like? ? apply_scopes(Location).all : nil
      end

      def min_name_like?
        params[:name_like].present? && params[:name_like].length >3
      end
    end
  end
end
