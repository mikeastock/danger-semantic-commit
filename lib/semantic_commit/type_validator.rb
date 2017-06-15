module Danger
  module SemanticCommit
    class TypeValidator
      def initialize(types)
        @types = types || default_types
      end

      def valid?(commit)
        subject = commit.fetch(:subject)

        type_from(subject) && types.include?(type_from(subject))
      end

      def message(_commit)
        <<~MSG
          Commit is missing a type.  Start your commit with one of the following:
          #{types.join(',')}

          For more information see: http://karma-runner.github.io/1.0/dev/git-commit-msg.html
        MSG
      end

      private

      attr_reader :types

      def type_from(subject)
        if matches = subject.match(/^(?<type>\w+)(\(|:)/)
          matches[:type]
        end
      end

      def default_types
        [
          "chore",
          "docs",
          "feat",
          "fix",
          "refactor",
          "style",
          "test",
        ]
      end
    end
  end
end
