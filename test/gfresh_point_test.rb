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

  def test_update_rule_point_and_name
    @client.update_rule_point(@rule.id, 200, 'hello')
    assert_equal 200, @rule.reload.point
    assert_equal 'hello', @rule.reload.name
  end

  def test_consume_point_with_enough_balance
    GfreshPoint::Repository::Balance.create!(
      app_id: 'demo_app', user_id: @user.id, point: 100,
      balance: 100, comment: @rule.to_json
    )
    balances = GfreshPoint::Repository::Balance.where(user_id: @user.id)
    assert_equal 1, balances.count
    assert_equal 100, balances.last.point
    ActiveRecord::Base.transaction do
      response = @client.consume_point(@user.id, 50, 'test', "xyz", false, {"foo": "bar"})
      assert response.success?
      assert_equal 50, response.value
    end
    assert_equal 50, balances.last.balance
  end

  def test_consume_point_without_enough_balance
    GfreshPoint::Repository::Balance.create!(
      app_id: 'demo_app', user_id: @user.id, point: 100,
      balance: 100, comment: @rule.to_json
    )
    balances = GfreshPoint::Repository::Balance.where(user_id: @user.id)
    assert_equal 1, balances.count
    assert_equal 100, balances.last.point
    ActiveRecord::Base.transaction do
      response = @client.consume_point(@user.id, 150, 'test', 'xyz', false, {"foo": "bar"})
      assert response.success?
      assert_equal 100, response.value
    end
    assert_equal 0, balances.last.balance
    assert_equal -100, balances.last.point
  end

  def test_consume_0_point_should_not_effect
    GfreshPoint::Repository::Balance.create!(
      app_id: 'demo_app', user_id: @user.id, point: 100,
      balance: 100, comment: @rule.to_json
    )
    begin_count = GfreshPoint::Repository::Balance.where(user_id: @user.id).count
    ActiveRecord::Base.transaction do
      response = @client.consume_point(@user.id, 0, 'test', 'xyz', false, {"foo": "bar"})
      assert response.success?
    end
    end_count = GfreshPoint::Repository::Balance.where(user_id: @user.id).count

    assert_equal begin_count, end_count
  end

  def test_earn_point_without_transaction
    response = @client.earn_point(@user.id, @rule.event_name)
    refute response.success?
  end

  def test_earn_0_point_should_note_effect
    disabled_rule = GfreshPoint::Repository::Rule.create(app_id: "demo_app", point: 0, event_name: "foo")
    begin_count = GfreshPoint::Repository::Balance.where(user_id: @user.id).count

    response = @client.earn_point(@user.id, disabled_rule.event_name)
    end_count = GfreshPoint::Repository::Balance.where(user_id: @user.id).count

    assert_equal begin_count, end_count
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
      app_id: 'demo_app', user_id: @user.id, point: 100,
      balance: 100, comment: @rule.to_json
    )
    response = @client.list_user_points(@user.id)
    assert_equal [balance], response.value
  end

  def test_list_user_points_with_query
    balance = GfreshPoint::Repository::Balance.create!(
      app_id: 'demo_app', user_id: @user.id, point: 100, balance: 100,
      event_name: 'test', origin_id: 1, comment: {"foo": "bar"}
    )
    response = @client.list_user_points(@user.id, 'test', 1)
    assert_equal [balance], response.value
  end

  def test_fetch_user_point_balance
    balance1 = GfreshPoint::Repository::Balance.create!(
      app_id: 'demo_app', user_id: @user.id, point: 100, balance: 100,
      event_name: 'test1', origin_id: 1, comment: {"foo": "bar"}
    )
    balance2 = GfreshPoint::Repository::Balance.create!(
      app_id: 'demo_app', user_id: @user.id, point: 100, balance: 100,
      event_name: 'test2', origin_id: 1, comment: {"foo": "bar"}
    )
    balance3 = GfreshPoint::Repository::Balance.create!(
      app_id: 'demo_app', user_id: @user.id, point: 100, balance: 100,
      event_name: 'test3', origin_id: 1, comment: {"foo": "bar"}
    )

    response = @client.fetch_user_points(@user.id, ['test1'], 1)
    assert_equal [balance1], response.value

    response = @client.fetch_user_points(@user.id, ['test2', 'test3'], 1)
    assert_equal [balance2, balance3].sort, response.value.sort

    response = @client.fetch_user_points(@user.id, ['test3'], 1)
    assert_equal [], response.value
  end

  def test_callback_hook
    GfreshPoint::Client.singleton_class.class_eval do
      define_method(:do_after_create_callback) do |balance|
        raise "callback works and balance point is #{balance.point}"
      end
    end

    err = assert_raises RuntimeError do
      ActiveRecord::Base.transaction do
        response = @client.earn_point(@user.id, @rule.event_name)
      end
    end
    assert_equal "callback works and balance point is #{@rule.point}", err.message

    GfreshPoint::Client.singleton_class.class_eval do
      define_method(:do_after_create_callback) do |balance|
        nil
      end
    end
  end

  def teardown
    DatabaseCleaner.clean
  end

end
