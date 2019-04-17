module GfreshPoint
  module Usecase
    class RuleListUsecase
      attr_accessor :repo # or attr_reader ???

      def initialize(repo)
        @repo = repo
      end

      def execute(request)
        rules = repo.list(filter: request.filters)
      end

    end
  end
end
