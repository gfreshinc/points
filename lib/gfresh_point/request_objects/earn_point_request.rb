module GfreshPoint
  module RequestObjects
    class EarnPointRequest < RequestObject
      attr_accessor :app_id, :user_id, :event_name, :origin_id

      def initialize(app_id, user_id, event_name, origin_id)
        @app_id = app_id
        @user_id = user_id
        @event_name = event_name
        @origin_id = origin_id

        if app_id.blank?
          add_error('app_id', "App id can not be blank")
        end
        if user_id.blank?
          add_error('user_id', "User id can not be blank")
        end
        if event_name.blank?
          add_error('event_name', "event_name can not be blank")
        end
      end

    end
  end
end
