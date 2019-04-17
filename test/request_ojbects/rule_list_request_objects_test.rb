require "test_helper"

module GfreshPoint
  module RequestObjects
    class RuleListRequestObjectsTest < Minitest::Test

      def test_buid_Rule_list_request_object_without_params
        request = RuleListRequestObject.new

        assert request.success?
        assert request.filters.empty?
      end

      def test_buid_Rule_list_request_object_with_empty_params
        request = RuleListRequestObject.new({})

        assert request.success?
        assert request.filters.empty?
      end

      def test_buid_Rule_list_request_object_with_empty_filters
        request = RuleListRequestObject.new(filters: {})

        assert request.success?
        assert request.filters.empty?
      end

      def test_buid_Rule_list_request_object_with_valid_filters
        request = RuleListRequestObject.new(filters: {app_id: 'gfreshx'})

        assert request.success?
      end

      def test_buid_Rule_list_request_object_with_invalid_filters
        request = RuleListRequestObject.new(filters: {a: 1})

        refute request.success?
        assert_equal 'filters', request.errors[0][:param]
      end


    end
  end
end
