module GfreshPoint
  module Usecase
    class BaseUsecase
      attr_accessor :repo # or attr_reader ???

      def initialize( repo)
        @repo = repo
      end

      def call(request)
          #  verify_request(request)
        if request.success?
          result = execute(request)
          generate_response(result)
        else
          ResponseFailure(ResponseFailure::PARAMETERS_ERROR, request.errors)
        end
      end

      # def verify_request(request)
      #   return ResponseFailure(request.) unless request.success?
      # end

      def generate_response(result)
        GfreshPoint::ResponseObjects::ResponseSuccess.new(result)
      end

      def execute(request)
        raise "Not impl"
      end

    end
  end
end
