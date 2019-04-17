module GfreshPoint
  module ResponseObjects
    class ResponseFailure
      RESOURCE_ERROR   = 'ResourceError'
      PARAMETERS_ERROR = 'ParametersError'
      SYSTEM_ERROR     = 'SystemError'

      def initialize(type, message)
        @type = type
        @message = message
      end

      def success?
        false
      end
    end
  end
end
