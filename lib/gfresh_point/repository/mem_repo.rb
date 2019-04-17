module GfreshPoint
  module Repository
    class MemRepo

      attr_accessor :data

      def initialize(data)
        @data = data
      end

      def list
        data
      end

    end
  end
end
