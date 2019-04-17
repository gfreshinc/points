require "test_helper"

module GfreshPoint
  module ResponseObjects
    class ResponseSuccessTest < Minitest::Test
      def test_response_success
        response = ResponseSuccess.new()
        assert response.success?
      end
    end
  end
end
