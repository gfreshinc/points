require "test_helper"

module GfreshPoint
  module Usecase
    class RuleListUsecaseTest < Minitest::Test
      def test_rule_list_usecase
        rule_seed = GfreshPoint::Domain::Rule.new(app_id: "beachpricex", event_name: "signup", point: 100)
        request_object = GfreshPoint::RequestObjects::RuleListRequest.new(filters: {app_id: "beachpricex"})
        repo =  GfreshPoint::Repository::MemRepo.new([rule_seed])

        use_case = GfreshPoint::Usecase::RuleListUsecase.new(repo)
        response = use_case.call(request_object)
        result = response.value

        assert_equal [rule_seed], result
      end
    end
  end
end
