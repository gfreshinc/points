require "test_helper"
require 'securerandom'

module GfreshPoint
  module Repository
    class ActiveRecordRepoTest < Minitest::Test
      def test_db_conntection
        assert User.first.nil?
      end

      # def test_should_raise_exception_if_not_in_transaction
      #   assert_raises Exception do
      #     GfreshPoint::Repository::ActiveRecordRepo.new
      #   end
      # end

    end
  end
end
