module GfreshPoint
  module RequestObjects
    class ListUserPointsRequest < RequestObject
      attr_reader :app_id, :user_id, :query

      def initialize(app_id, user_id, query)
        @app_id = app_id
        @user_id = user_id
        @query = query

        if user_id.blank?
          add_error('user_id', "User id can not be blank")
        end
        if app_id.blank?
          add_error('app_id', "App id can not be blank")
        end
      end

    end
  end
end
