module GfreshPoint
  module Usecase
    class ConsumePointUsecase < BaseUsecase
      def execute(request)
        rule = repo.get_rule_by_event_name(request.app_id, request.event_name)
        raise "Rule not exist" if rule.blank?
        last_balance = repo.get_user_last_balance(request.app_id, request.user_id).try(:balance).to_i
        if rule.point.to_i > last_balance
          request.add_error('point', 'not enough balance point')
        else
          # save balance and rule snapshot
          repo.create_balance(request.app_id, request.user_id, rule.point * -1, last_balance - rule.point, rule.to_json)
        end
      end
    end
  end
end
