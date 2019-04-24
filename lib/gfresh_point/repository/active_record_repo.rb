require 'active_record'

module GfreshPoint
  module Repository
    class ActiveRecordRepo

      def list_rules(app_id)
        Rule.where(app_id: app_id)
      end

      def update_rule_point(app_id, rule_id, point)
        Rule.find(rule_id).update!(point: point)
      end

      def get_user_last_balance(app_id, user_id)
        Balance.where(app_id: app_id).where(user_id: user_id).
          order(created_at: desc).first
      end

      def create_balance(app_id, user_id, point, balance)
        transaction_protect
        Balance.create!(app_id: app_id, user_id: user_id, point: point, balance: balance)
      end

      private

      def is_in_transcation?
        !(ActiveRecord::Base.connection.open_transactions == 0)
      end

      def transaction_protect
        unless is_in_transcation?
          raise "Point operation must be in a transaction "
        end
      end
    end

    class Rule < ActiveRecord::Base
      self.table_name = "gfresh_point_rules"
    end

    class Balance < ActiveRecord::Base
      self.table_name = "gfresh_point_balances"
    end
  end
end
