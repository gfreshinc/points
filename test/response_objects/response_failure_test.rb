require "test_helper"

module GfreshPoint
  module ResponseObjects
    class ResponseSuccessTest < Minitest::Test
      def test_response_failed
        response = ResponseFailure.new(
          GfreshPoint::ResponseObjects::ResponseFailure::RESOURCE_ERROR,
          "hello"
        )
        assert_equal "hello", response.message
      end
    end
  end
end
