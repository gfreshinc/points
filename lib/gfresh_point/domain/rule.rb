module GfreshPoint
  module Domain
    class Rule

      attr_accessor :app_id, :event_name, :point

      def initialize(app_id:, event_name:, point:)
        @app_id = app_id
        @event_name = event_name
        @point = point
      end

    end
  end
end
