require "test_helper"

class GfreshPointTest < Minitest::Test

  def setup
    @client = GfreshPoint::Client.new('demo_app')
    @user = User.create!(email: "gfresh_point@example.com")
    @rule = GfreshPoint::Repository::Rule.create(app_id: "demo_app", point: 100, event_name: "signup")
  end

  def test_that_it_has_a_version_number
    refute_nil ::GfreshPoint::VERSION
  end

  def test_list_rules
    response = @client.list_rules
    assert_equal [@rule], response.value
  end

  def test_update_rule_point
    @client.update_rule_point(@rule.id, 200)
    assert_equal 200, @rule.reload.point
  end

  def teardown
    DatabaseCleaner.clean
  end

end
