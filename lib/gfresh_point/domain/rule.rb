module GfreshPoint
  module Domain
    class Rule

      attr_accessor :app_id, :event_name, :point

      def initialize(app_id:, event_name:, point:)
        @app_id = app_id
        @event_name = event_name
        @point = point
      end

      def ==(other)
        app_id == other.app_id && \
        event_name == other.event_name && \
        point == other.point
      end
    end
  end
end
