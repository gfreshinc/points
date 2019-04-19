module GfreshPoint
  module Usecase
    class RuleListUsecase < BaseUsecase
      def execute(request)
        # rules = repo.list(filter: request.filters)
        rules = repo.list_rules(request.filters[:app_id])
      end
    end
  end
end
