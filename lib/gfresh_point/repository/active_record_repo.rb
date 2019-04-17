module GfreshPoint
  module Repository
    class ActiveRecordRepo
      def list_rules(app_id)
        Rule.where(app_id: app_id)
      end

      def create_rule(app_id, event_name, point)

      end
    end

    class Rule < ApplicationRecord
      self.table_name = "gfresh_point_rules"
    end
  end
end
