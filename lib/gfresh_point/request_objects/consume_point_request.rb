module GfreshPoint
  module RequestObjects
    class ConsumePointRequest < RequestObject
      attr_accessor :app_id, :user_id, :point, :event_name, :origin_id, :comment

      def initialize(app_id, user_id, point, event_name, origin_id, comment)
        @app_id = app_id
        @user_id = user_id
        @point = point
        @event_name = event_name
        @origin_id = origin_id
        @comment = comment

        if app_id.blank?
          add_error('app_id', "App id can not be blank")
        end
        if user_id.blank?
          add_error('user_id', "User id can not be blank")
        end
        if point.blank?
          add_error('point', "point can not be blank")
        elsif point < 0
          add_error('point', "point must larger than 0")
        end
      end

    end
  end
end
