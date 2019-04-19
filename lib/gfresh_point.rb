require "gfresh_point/version"
require "gfresh_point/domain/rule"
# require "gfresh_point/serializers/rule_json_encoder"
require "gfresh_point/usecase/base_usecase"
require "gfresh_point/usecase/rule_list_usecase"
require "gfresh_point/repository/mem_repo"
require "gfresh_point/repository/active_record_repo"
require "gfresh_point/request_objects/request_object"
require "gfresh_point/request_objects/rule_list_request"
require "gfresh_point/request_objects/update_rule_point_request"
require "gfresh_point/response_objects/response_success"
require "gfresh_point/response_objects/response_failure"

# Generators
require 'generators/gfresh_point/install/install_generator'
require 'active_record'

module GfreshPoint
  class Error < StandardError; end
  # Your code goes here...
end
