module GfreshPoint
  module Usecase
    class ConsumePointUsecase < BaseUsecase
      def execute(request)
        last_balance = repo.get_user_last_balance(request.app_id, request.user_id).try(:balance).to_i
        consumed_point = [request.point, last_balance].min
        # save balance and rule snapshot
        repo.create_balance(request.app_id, request.user_id, request.point * -1, last_balance - consumed_point, request.event_name, request.origin_id, request.to_json)
        consumed_point
      end
    end
  end
end
