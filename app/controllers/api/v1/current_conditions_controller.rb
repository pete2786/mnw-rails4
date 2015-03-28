module Api
  module V1
    class CurrentConditionsController < Api::V1::BaseController
      before_filter :check_params, only: [:create]
      decorates_assigned :current_condition

      def create
        @current_condition = CurrentCondition.with(params)
        @current_condition.forecast_pending = false
        @current_condition.save
        respond_with(@current_condition)
      end

      def show
        @current_condition = CurrentCondition.find(params[:id])
        respond_with(@current_condition)
      end

      def forecast
        @current_condition = CurrentCondition.find(params[:current_condition_id])
        @current_condition.fetch_forecast
      end

      def check_params
        params.require(:location)
      end
    end
  end
end
