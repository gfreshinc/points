require "test_helper"
require 'securerandom'

module GfreshPoint
  module Repository
    class ActiveRecordRepoTest < Minitest::Test
      def test_db_conntection
        assert User.first.nil?
      end
    end
  end
end
