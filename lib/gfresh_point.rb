require "gfresh_point/version"
require "gfresh_point/domain/rule"
# require "gfresh_point/serializers/rule_json_encoder"
require "gfresh_point/usecase/base_usecase"
require "gfresh_point/usecase/rule_list_usecase"
require "gfresh_point/usecase/update_rule_point_usecase"
require "gfresh_point/usecase/earn_point_usecase"
require "gfresh_point/usecase/consume_point_usecase"
require "gfresh_point/usecase/list_user_points_usecase"

require "gfresh_point/repository/mem_repo"
require "gfresh_point/repository/active_record_repo"

require "gfresh_point/request_objects/request_object"
require "gfresh_point/request_objects/rule_list_request"
require "gfresh_point/request_objects/update_rule_point_request"
require "gfresh_point/request_objects/earn_point_request"
require "gfresh_point/request_objects/consume_point_request"
require "gfresh_point/request_objects/list_user_points_request"

require "gfresh_point/response_objects/response_success"
require "gfresh_point/response_objects/response_failure"

# Generators
require 'generators/gfresh_point/install/install_generator'
require 'active_record'

module GfreshPoint
  class Client
    attr_reader :app_id, :repo
    def initialize(app_id, repo = GfreshPoint::Repository::ActiveRecordRepo.new)
      @app_id = app_id
      @repo = repo
    end

    def list_rules
      request = GfreshPoint::RequestObjects::RuleListRequest.new(filters: {app_id: app_id})
      use_case = GfreshPoint::Usecase::RuleListUsecase.new(repo)
      response = use_case.call(request)
      response
    end

    def update_rule_point(rule_id, point)
      request = GfreshPoint::RequestObjects::UpdateRulePointRequest.new(app_id, rule_id, point)
      use_case = GfreshPoint::Usecase::UpdateRulePointUsecase.new(repo)
      response = use_case.call(request)
      response
    end

    def consume_point(user_id, point, comment = {})
      request = GfreshPoint::RequestObjects::ConsumePointRequest.new(app_id, user_id, point, comment)
      use_case = GfreshPoint::Usecase::ConsumePointUsecase.new(repo)
      response = use_case.call(request)
      response
    end

    def earn_point(user_id, event_name)
      request = GfreshPoint::RequestObjects::EarnPointRequest.new(app_id, user_id, event_name)
      use_case = GfreshPoint::Usecase::EarnPointUsecase.new(repo)
      response = use_case.call(request)
      response
    end

    def list_user_points(user_id)
      request = GfreshPoint::RequestObjects::ListUserPointsRequest.new(app_id, user_id)
      use_case = GfreshPoint::Usecase::ListUserPointsUsecase.new(repo)
      response = use_case.call(request)
      response
    end

  end
end
