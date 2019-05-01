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

  def test_consume_point
    GfreshPoint::Repository::Balance.create!(
      app_id: 'demo_app', user_id: @user.id, point: 100, balance: 100, comment: @rule.to_json
    )
    balances = GfreshPoint::Repository::Balance.where(user_id: @user.id)
    assert_equal 1, balances.count
    assert_equal 100, balances.last.point
    ActiveRecord::Base.transaction do
      response = @client.consume_point(@user.id, 50)
      assert response.success?
    end
    assert_equal 50, balances.last.balance
  end

  def test_earn_point_without_transaction
    response = @client.earn_point(@user.id, @rule.event_name)
    refute response.success?
  end

  def test_earn_point_with_transaction
    ActiveRecord::Base.transaction do
      response = @client.earn_point(@user.id, @rule.event_name)
      assert response.success?
    end
    balances = GfreshPoint::Repository::Balance.where(user_id: @user.id)
    assert_equal 1, balances.count
    assert_equal 100, balances.last.point
    assert_equal 100, balances.last.balance
  end

  def test_list_user_points
    balance = GfreshPoint::Repository::Balance.create!(
      app_id: 'demo_app', user_id: @user.id, point: 100, balance: 100, comment: @rule.to_json
    )
    response = @client.list_user_points(@user.id)
    assert_equal [balance], response.value
  end

  def teardown
    DatabaseCleaner.clean
  end

end
