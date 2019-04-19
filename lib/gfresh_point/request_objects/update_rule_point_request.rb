module GfreshPoint
  module RequestObjects
    class UpdateRulePointRequest < RequestObject
      attr_accessor :filters

      ACCEPTED_FILTERS = ['app_id']

      def initialize(params = {}) 
        @filters = params[:filters] || {}
        @filters.keys.each do |filter|
          unless ACCEPTED_FILTERS.include?(filter.to_s)
            add_error('filters', "Key #{filter} can not be used")
          end
        end
      end

    end
  end
end
