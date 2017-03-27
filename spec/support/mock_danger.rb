module MockDanger
  # These functions are a subset of
  # https://github.com/danger/danger/blob/master/spec/spec_helper.rb
  # If you are expanding these files, see if it's already been done ^.

  # A stubbed out Dangerfile for use in tests
  def mock_danagerfile
    env = Danger::EnvironmentManager.new(testing_env)
    Danger::Dangerfile.new(env, testing_ui)
  end

  private

  # A silent version of the user interface
  def testing_ui
    Cork::Board.new(silent: true)
  end

  # Example environment (ENV) that would come from
  # running a PR on TravisCI
  def testing_env
    {
      "DANGER_GITHUB_API_TOKEN" => "123sbdq54erfsd3422gdfio",
      "HAS_JOSH_K_SEAL_OF_APPROVAL" => "true",
      "TRAVIS_COMMIT_RANGE" => "759adcbd0d8f...13c4dc8bb61d",
      "TRAVIS_PULL_REQUEST" => "800",
      "TRAVIS_REPO_SLUG" => "artsy/eigen",
    }
  end
end

RSpec.configure do |config|
  config.include MockDanger
end
