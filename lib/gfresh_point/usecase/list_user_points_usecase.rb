module GfreshPoint
  module Usecase
    class ListUserPointsUsecase < BaseUsecase
      def execute(request)
        repo.list_user_points(request.app_id, request.user_id, request.event_name, request.origin_id)
      end
    end
  end
end
