module Api
  module V1
    class BaseController < ActionController::Base
      layout 'api/v1/layouts/application'

      respond_to :json
      self.responder = Api::V1::ApplicationResponder

      around_filter :set_time_zone

      rescue_from ActionController::ParameterMissing, CanCan::AccessDenied do |e|
        rescue_error status: :bad_request, messages: e.message
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        rescue_error status: 404, message: "Record not found"
      end

      def rescue_error(options = {})
        messages = ([options[:messages]] + [options[:message]]).flatten.compact
        @error = [options[:status], *messages]
        
        render layout: 'api/v1/layouts/application', :locals => { :error => @error }
      end

      def set_time_zone(&block)
        time_zone = 'Central Time (US & Canada)'
        Time.use_zone(time_zone, &block)
      end
    end
  end
end
