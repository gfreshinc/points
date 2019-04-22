module GfreshPoint
  module Usecase
    class EarnPointUsecase < BaseUsecase
      def execute(request)
        last_balance = repo.get_user_last_balance(request.user_id).try(:balance).to_i

        rules = repo.create_balance(request.app_id, request.user_id, request.point, last_balance + request.point)
      end
    end
  end
end
