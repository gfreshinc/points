module GfreshPoint
  module Usecase
    class ConsumePointUsecase < BaseUsecase
      def execute(request)
        last_balance = repo.get_user_last_balance(request.app_id, request.user_id).try(:balance).to_i
        if request.point > last_balance
          request.add_error('point', 'not enough balance point')
        else
          # save balance and rule snapshot
          repo.create_balance(request.app_id, request.user_id, request.point * -1, last_balance - request.point, request.to_json)
        end
      end
    end
  end
end
