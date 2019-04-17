module GfreshPoint
  module RequestObjects
    class RequestObject
      def add_error(param, message)
        errors << {'param': param, message: message}
      end

      def has_errors
        errors.count > 0
      end

      def success?
        !has_errors
      end

      def errors
        @errors ||= []
      end
    end
  end
end
