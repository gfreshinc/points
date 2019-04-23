module GfreshPoint
  module Repository
    class MemRepo

      attr_accessor :data

      def initialize(data)
        @data = data
      end

      def list_rules(app_id)
        data.select {|d| d.app_id == app_id}
      end

    end
  end
end
