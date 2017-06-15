require "test_helper"

module Danger
  module SemanticCommit
    class TypeValidatorTest < Minitest::Test
      def test_valid
        message = "feat(user-signup): User's can now sign up"
        commit = { subject: message }

        assert TypeValidator.new(["feat"]).valid?(commit)
      end
    end
  end
end
