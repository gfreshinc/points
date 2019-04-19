require "test_helper"

module GfreshPoint
  module RequestObjects
    class RuleListRequestsTest < Minitest::Test

      def test_buid_rule_list_request_object_without_params
        request = RuleListRequest.new

        assert request.success?
        assert request.filters.empty?
      end

      def test_buid_rule_list_request_object_with_empty_params
        request = RuleListRequest.new({})

        assert request.success?
        assert request.filters.empty?
      end

      def test_buid_rule_list_request_object_with_empty_filters
        request = RuleListRequest.new(filters: {})

        assert request.success?
        assert request.filters.empty?
      end

      def test_buid_rule_list_request_object_with_valid_filters
        request = RuleListRequest.new(filters: {app_id: 'gfreshx'})

        assert request.success?
      end

      def test_buid_rule_list_request_object_with_invalid_filters
        request = RuleListRequest.new(filters: {a: 1})

        refute request.success?
        assert_equal 'filters', request.errors[0][:param]
      end


    end
  end
end
