# frozen_string_literal: true

require "test_helper"

class TestGitFonkyRepositories < Minitest::Test
  def test_parse_env
    ENV["GFONK_REPOS"] = "repo1,repo2:staging"

    repo_hash = GitFonky::Parser.parse_env

    assert_equal({repo1: nil, repo2: "staging"}, repo_hash.config)
  end
end
