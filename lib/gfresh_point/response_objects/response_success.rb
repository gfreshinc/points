module GfreshPoint
  module ResponseObjects
    class ResponseSuccess
      attr_accessor :value

      def initialize(value = nil)
        @value = value
      end

      def success?
        true
      end
    end
  end
end
