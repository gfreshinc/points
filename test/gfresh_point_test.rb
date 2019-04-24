require "test_helper"

class GfreshPointTest < Minitest::Test

  def setup
    @client = GfreshPoint::Client.new('demo_app')
  end

  def test_that_it_has_a_version_number
    refute_nil ::GfreshPoint::VERSION
  end

  # def test_list_

end
