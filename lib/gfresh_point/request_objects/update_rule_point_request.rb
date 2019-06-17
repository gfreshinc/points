module GfreshPoint
  module RequestObjects
    class UpdateRulePointRequest < RequestObject
      attr_accessor :app_id, :rule_id, :point, :name

      def initialize(app_id, rule_id, point, name)
        @app_id = app_id
        @rule_id = rule_id
        @name = name
        @point = point

        if app_id.blank?
          add_error('app_id', "App id can not be blank")
        end
        if rule_id.blank?
          add_error('rule_id', "Rule id can not be blank")
        end
        if point.blank?
          add_error('app_id', "Point can not be blank")
        end
      end

    end
  end
end
