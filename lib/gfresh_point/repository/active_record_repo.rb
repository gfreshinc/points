require 'active_record'

module GfreshPoint
  module Repository
    class ActiveRecordRepo

      def list_rules(app_id)
        Rule.where(app_id: app_id)
      end

      def update_rule_point(app_id, rule_id, point, name)
        Rule.find(rule_id).update!(point: point, name: name)
      end

      def get_user_last_balance(app_id, user_id)
        Balance.where(app_id: app_id).where(user_id: user_id).
          order(created_at: :desc).first
      end

      def create_balance(app_id, user_id, point, balance, event_name, origin_id, comment)
        transaction_protect
        Balance.create!(app_id: app_id, user_id: user_id, point: point, balance: balance,
                        origin_id: origin_id, event_name: event_name, comment: comment)
      end

      def get_rule_by_event_name(app_id, event_name)
        Rule.where(app_id: app_id).where(event_name: event_name).first
      end

      def list_user_points(app_id, user_id, event_name, origin_id)
        query = Balance.where(app_id: app_id).where(user_id: user_id)
        query = query.where(event_name: event_name) if event_name.presence
        query = query.where(origin_id: origin_id) if origin_id.presence
        query.order(created_at: :desc)
      end

      def fetch_user_points(app_id, user_id, event_name, origin_id)
        result = list_user_points(app_id, user_id, event_name, origin_id)
        result = result.where(read_at: nil)
        return_result = result.to_a
        result.update_all(read_at: Time.now)
        return_result
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
