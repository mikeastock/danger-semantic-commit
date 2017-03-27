require "spec_helper"

module Danger
  module SemanticCommit
    RSpec.describe TypeValidator do
      describe ".type_from" do
        it "extracts type from subject" do
          message = "feat(user-signup): User's can now sign up"

          expect(TypeValidator.type_from(message)).to eq("feat")
        end

        it "returns nil if there is no type" do
          message = "User's can now sign up"

          expect(TypeValidator.type_from(message)).to be nil
        end
      end
    end
  end
end
