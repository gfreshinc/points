$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "gfresh_point"

require "minitest/autorun"
require "pry"

require 'active_record'
require 'database_cleaner'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

load File.dirname(__FILE__) + '/repository/schema.rb'
# require File.dirname(__FILE__) + '/models.rb'
class User < ActiveRecord::Base
end

DatabaseCleaner.strategy = :truncation
