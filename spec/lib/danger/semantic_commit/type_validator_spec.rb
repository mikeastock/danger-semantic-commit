require "spec_helper"

module Danger
  module SemanticCommit
    RSpec.describe TypeValidator do
      describe "#valid?" do
        context "user specifies type" do
          it "checks that the type is exists and is valid" do
            message = "feat(user-signup): User's can now sign up"
            commit = { subject: message }

            expect(TypeValidator.new(["feat"]).valid?(commit)).to be true
          end
        end
      end
    end
  end
end
