module GfreshPoint
  module RequestObjects
    class UpdateRulePointRequest < RequestObject
      attr_accessor :app_id, :rule_id, :point

      def initialize(app_id, rule_id, point)
        @app_id = app_id
        @rule_id = rule_id
        @point = point

        if app_id.blank?
          add_error('app_id', "App id can not be blank")
        end
        if rule_id.blank?
          add_error('rule_id', "Id #{rule_id} can not be blank")
        end
        if point.blank?
          add_error('app_id', "Point can not be blank")
        end
      end

    end
  end
end
