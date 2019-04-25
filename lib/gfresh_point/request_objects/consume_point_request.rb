module GfreshPoint
  module RequestObjects
    class ConsumePointRequest < RequestObject
      attr_accessor :app_id, :user_id, :point

      def initialize(app_id, user_id, point)
        @app_id = app_id
        @user_id = user_id
        @point = point

        if app_id.blank?
          add_error('app_id', "App id can not be blank")
        end
        if user_id.blank?
          add_error('user_id', "User id can not be blank")
        end
        if point.to_i < 0
          add_error('point', "Point must larger than 0")
        end
      end

    end
  end
end
