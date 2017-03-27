module Danger
  # Run each commit in the PR through a message linting.
  #
  #  Semantic commit lint will check each commit in the PR to ensure the
  #  following is true:
  #
  #  * Commit subject begins with a type
  #  * Commit subject has a scope (`scope`)
  #  * Commit subject is no longer than 70 characters (`length`)
  #
  #  By default, Semantic Commit Lint fails, but you can configure this behavior.
  #
  #
  # @example Lint all commits using defaults
  #
  #          semantic_commit.check
  #
  # @example Warn instead of fail
  #
  #          semantic_commit.check warn: :all
  #
  # @example Disable a particular check
  #
  #          semantic_commit.check disable: [:length]
  #
  # @example Configure semantic types
  #
  #          semantic_commit.check types: ["feat", "fix", "docs"]
  #
  # @see danger/danger
  # @tags commit linting
  #
  class DangerSemanticCommit < Plugin
    def check(config = {})
      self.config = config
      check_commits
    end

    private

    attr_accessor :config

    def check_commits
      commits.each do |commit|
        validate(commit)
      end
    end

    def validate(commit)
      enabled_checkers.all? do |checker|
        checker.call(commit)
      end
    end

    def commits
      git.commits.map do |commit|
        subject, _ = commit.message.split("\n")
        {
          sha: commit.sha,
          subject: subject,
        }
      end
    end

    def enabled_checkers
      checkers.reject do |checker|
        config.fetch(:disabled, []).include?(checker)
      end
    end

    def checkers
      [
        Length,
        Scope,
        Type,
      ]
    end
  end
end
