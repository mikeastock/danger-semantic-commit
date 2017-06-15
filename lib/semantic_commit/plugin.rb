require "danger"

module Danger
  # Run each commit in the PR through a message linting.
  #
  #  Semantic commit lint will validate each commit in the PR to ensure the
  #  following is true:
  #
  #  * Commit subject begins with a type
  #  * Commit subject is no longer than 70 characters (`length`)
  #
  #  By default, Semantic Commit Lint fails, but you can configure this behavior.
  #
  #
  # @example Lint all commits using defaults
  #
  #          semantic_commit.validate
  #
  # @example Warn instead of fail
  #
  #          semantic_commit.validate warn: :all
  #
  # @example Disable a particular validator
  #
  #          semantic_commit.validate disable: [:length]
  #
  # @example Configure semantic types
  #
  #          semantic_commit.validate types: ["feat", "fix", "docs"]
  #
  # @example Configure length
  #
  #          semantic_commit.validate length: 100
  #
  # @see danger/danger
  # @tags commit linting
  #
  class DangerSemanticCommit < Plugin
    # Validates the commits with whatever config the user passes.
    #
    # Passing in a hash which contain the following keys:
    #
    #  * `disable` - array of checks to skip
    #  * `fail` - array of checks to fail on
    #  * `warn` - array of checks to warn on
    #
    #  The current check types are:
    #
    #  * `length`
    #
    #  Note: you can pass :all instead of an array to target all checks.
    #
    # @param [Hash] config
    #
    # @return [void]
    #
    def validate(config = {})
      self.config = config

      commits.each do |commit|
        enabled_validators.each do |validator|
          if !validator.valid?(commit)
            message = validator.message(commit)
            messaging.fail([message, commit.fetch(:sha)].join("\n"))
          end
        end
      end
    end

    private

    attr_accessor :config

    def commits
      git.commits.map do |commit|
        subject, _ = commit.message.split("\n")
        {
          sha: commit.sha,
          subject: subject,
        }
      end
    end

    def enabled_validators
      validators.reject do |validator|
        config.fetch(:disabled, []).include?(validator)
      end
    end

    def validators
      @validators ||= build_validators
    end

    def build_validators
      [
        Danger::SemanticCommit::LengthValidator.new(config[:length]),
        Danger::SemanticCommit::TypeValidator.new(config[:types]),
      ]
    end
  end
end
