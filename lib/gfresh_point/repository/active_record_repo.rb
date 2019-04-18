
module GfreshPoint
  module Repository
    class ActiveRecordRepo
      def list_rules(app_id)
        Rule.where(app_id: app_id)
      end

      def update_rule_point(app_id, rule_id, point)
        Rule.find(rule_id).update!(point: point)
      end
    end

    class Rule < ActiveRecord::Base
      self.table_name = "gfresh_point_rules"
    end
  end
end
