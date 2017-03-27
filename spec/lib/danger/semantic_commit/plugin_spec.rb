require "spec_helper"

RSpec.describe Danger::DangerSemanticCommit do
  describe "#validate" do
    context "default config" do
      it "validates commits to be semantic" do
        plugin = mock_danagerfile.semantic_commit

        commit = double(
          message: "This is not a semantic commit.",
          sha: "137e45fe05bfcf0013cab23ff2ab1608fc26e7ac",
        )

        git = double(commits: [commit])
        allow(plugin).to receive(:git).and_return(git)

        plugin.validate

        expect(plugin.status_report[:errors]).to eq(
          [
            ["Commit subject is too short", commit.sha],
            ["Commit is missing a scope", commit.sha],
            ["Commit is missing a type", commit.sha],
          ],
        )
      end
    end
  end
end
