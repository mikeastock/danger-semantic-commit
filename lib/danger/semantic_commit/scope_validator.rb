module Danger
  module SemanticCommit
    class ScopeValidator
      def valid?(commit)
        subject = commit.fetch(:subject)

        !subject.match(/\(\w+\):/).nil?
      end

      def message(_commit)
        "Commit is missing a scope"
      end
    end
  end
end
