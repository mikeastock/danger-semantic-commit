module Danger
  module SemanticCommit
    class ScopeValidator
      def self.valid?(commit)
        subject = commit.fetch(:subject)

        !subject.match(/\(\w+\):/).nil?
      end

      def self.message(_commit)
        "Commit is missing a scope"
      end
    end
  end
end
