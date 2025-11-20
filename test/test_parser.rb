# frozen_string_literal: true

require "test_helper"

class TestParser < Minitest::Test
  def test_parse_env
    ENV["GFONK_REPOS"] = "repo1,repo2:staging"

    repo_config = GitFonky::Parser.parse_env

    config = [
      {
        repo: "repo1", branch: nil, origin_remote: nil, fork_remote: nil
      },
      {
        repo: "repo2", branch: "staging", origin_remote: nil, fork_remote: nil
      }
    ]

    assert_equal(config, repo_config)
  end
end
