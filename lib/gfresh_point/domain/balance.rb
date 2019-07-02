module GfreshPoint
  module Domain
    class Balance

      attr_accessor :app_id, :user_id, :point, :balance

      def initialize(app_id:, user_id:, point:, balance:)
        @app_id = app_id
        @user_id = user_id
        @point = point
        @balance = balance
      end
    end
  end
end
