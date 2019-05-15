module GfreshPoint
  module Usecase
    class ListUserPointsUsecase < BaseUsecase
      def execute(request)
        repo.list_user_points(request.app_id, request.user_id, request.query)
      end
    end
  end
end
