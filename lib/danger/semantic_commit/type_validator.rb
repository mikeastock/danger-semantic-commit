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
        "Commit is missing a type"
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
