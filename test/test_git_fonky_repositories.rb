# frozen_string_literal: true

require "test_helper"

class TestGitFonkyParser < Minitest::Test
  def test_parse_env
    ENV["GFONK_REPOS"] = "repo1,repo2:staging"

    repo_hash = GitFonky::Parser.parse_env

    config_hash = {
      0 => {
        repo: "repo1", branch: nil, origin_remote: nil, fork_remote: nil
      },
      1 => {
        repo: "repo2", branch: "staging", origin_remote: nil, fork_remote: nil
      }
    }

    assert_equal(config_hash, repo_hash.config)
  end
end
