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

    assert_equal(
      plugin.status_report[:errors],
      [
        ["Commit subject is too long", commit.sha].join("\n"),
        ["Commit is missing a scope", commit.sha].join("\n"),
        ["Commit is missing a type", commit.sha].join("\n"),
      ],
    )
  end
end
