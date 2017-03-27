module Danger
  module SemanticCommit
    class LengthValidator
      def self.valid?(commit)
        commit.fetch(:subject).length > 50
      end

      def self.message(_commit)
        "Commit subject is too short"
      end
    end
  end
end
