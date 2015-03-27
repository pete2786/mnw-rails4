module Api
  module V1
    class CurrentConditionsController < Api::V1::BaseController
      decorates_assigned :current_condition

      def create
        @current_condition = CurrentCondition.with(condition_params)
        @current_condition.save
        respond_with(@current_condition)
      end

      def show
        @current_condition = CurrentCondition.find(params[:id])
        respond_with(@current_condition)
      end

      def condition_params
        {
          current_condition: {
            location: params[:location],
          },
          lat: params[:lat],
          long: params[:long],
        }
      end
    end
  end
end
