module GfreshPoint
  module Usecase
    class UpdateRulePointUsecase < BaseUsecase
      def execute(request)
        rules = repo.update_rule_point(request.app_id, request.rule_id, request.point)
      end
    end
  end
end
