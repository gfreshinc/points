module GfreshPoint
  module Usecase
    class ConsumePointUsecase < BaseUsecase
      def execute(request)
        last_balance = repo.get_user_last_balance(request.user_id).try(:balance).to_i
        if request.point.to_i > last_balance
          request.add_error('point', 'not enough balance point')
        else
          rules = repo.create_balance(request.app_id, request.user_id, request.point, last_balance + request.point)
        end
      end
    end
  end
end
