module GfreshPoint
  module Usecase
    class ConsumePointUsecase < BaseUsecase
      def execute(request)
        last_balance = repo.get_user_last_balance(request.app_id, request.user_id).try(:balance).to_i
        if request.force
          raise "not enough point" if request.point > last_balance
          consumed_point = request.point
        else
          consumed_point = [request.point, last_balance].min
        end
        # save balance and rule snapshot
        if consumed_point > 0
          repo.create_balance(request.app_id, request.user_id, consumed_point * -1, last_balance - consumed_point, request.event_name, request.origin_id, request.comment)
        end
        consumed_point
      end
    end
  end
end
