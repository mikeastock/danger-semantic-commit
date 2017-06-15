require "test_helper"

class Danger::DangerSemanticCommitTest < Minitest::Test
  include MockDanger

  module MockedGit
    attr_accessor :commit

    def git
      OpenStruct.new(commits: [commit])
    end
  end

  Danger::DangerSemanticCommit.prepend(MockedGit)

  def test_validate
    plugin = mock_danagerfile.semantic_commit

    commit = OpenStruct.new(
      message: "This is not a semantic commit." + "way too long" * 100,
      sha: "137e45fe05bfcf0013cab23ff2ab1608fc26e7ac",
    )

    plugin.commit = commit
    plugin.validate

    type_message = <<~MSG
      Commit is missing a type.  Start your commit with one of the following:
      chore,docs,feat,fix,refactor,style,test

      For more information see: http://karma-runner.github.io/1.0/dev/git-commit-msg.html
    MSG

    assert_equal(
      plugin.status_report[:errors],
      [
        ["Commit subject is too long", commit.sha].join("\n"),
        [type_message, commit.sha].join("\n"),
      ],
    )
  end
end
