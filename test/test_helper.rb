$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "danger/semantic_commit"

require "minitest/reporters"
Minitest::Reporters.use!

Dir["test/support/**/*.rb"].each { |f| require File.expand_path(f) }

require "minitest/autorun"
