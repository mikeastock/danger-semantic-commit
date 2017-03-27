module Danger
  module SemanticCommit
    class TypeValidator
      def self.valid?(commit)
        subject = commit.fetch(:subject)

        type_from(subject) && default_types.include?(type_from(subject))
      end

      def self.message(_commit)
        "Commit is missing a type"
      end

      def self.type_from(subject)
        if matches = subject.match(/^(?<type>\w+)(\(|:)/)
          matches[:type]
        end
      end

      def self.default_types
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
