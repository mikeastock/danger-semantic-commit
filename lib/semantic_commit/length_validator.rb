module Danger
  module SemanticCommit
    class LengthValidator
      def initialize(length)
        @length = length || default_length
      end

      def valid?(commit)
        commit.fetch(:subject).length < length
      end

      def message(_commit)
        "Commit subject is too long"
      end

      private

      attr_reader :length

      def default_length
        70
      end
    end
  end
end
