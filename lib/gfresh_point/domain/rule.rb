module GfreshPoint
  module Domain
    class Rule
      attr_accessor :app_id, :event_name, :point, :name

      def initialize(app_id:, event_name:, point:, name: nil)
        @app_id = app_id
        @name = name
        @event_name = event_name
        @point = point
      end

    end
  end
end
