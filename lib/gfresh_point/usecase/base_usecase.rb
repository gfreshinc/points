module GfreshPoint
  module Usecase
    class BaseUsecase
      attr_accessor :repo # or attr_reader ???

      def initialize( repo)
        @repo = repo
      end

      def call(request)
        if request.success?
          result = execute(request)
          generate_response(result)
        else
          GfreshPoint::ResponseObjects::ResponseFailure.new(GfreshPoint::ResponseObjects::ResponseFailure::PARAMETERS_ERROR, request.errors)
        end
      rescue StandardError => e
        GfreshPoint::ResponseObjects::ResponseFailure.new(GfreshPoint::ResponseObjects::ResponseFailure::SYSTEM_ERROR, e.message)
      end

      def generate_response(result)
        GfreshPoint::ResponseObjects::ResponseSuccess.new(result)
      end

      def execute(request)
        raise "Not impl"
      end

    end
  end
end
