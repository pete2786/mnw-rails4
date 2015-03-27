module Api
  module V1
    class ApplicationResponder < ActionController::Responder

      def to_format
        if has_errors?
          display_errors
        else
          set_status
          render_view
        end
      rescue ActionView::MissingTemplate => e
        api_behavior(e)
      end

      def display_errors
        controller.rescue_error(status: :unprocessable_entity, messages: resource.errors.to_a)
      end

      def set_status
        controller.response.status = :created if post?
      end

      def render_view
        if get?
          default_render
        else
          render action: :show
        end
      end
      private :render_view

    end
  end
end
