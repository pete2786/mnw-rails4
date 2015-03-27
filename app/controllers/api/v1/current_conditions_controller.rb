module Api
  module V1
    class CurrentConditionsController < Api::V1::BaseController
      decorates_assigned :current_condition

      def create
        byebug
        @current_condition = CurrentCondition.with(params)
        @current_condition.save
        respond_with(@current_condition)
      end

      def show
        @current_condition = CurrentCondition.find(params[:id])
        respond_with(@current_condition)
      end
    end
  end
end
