# frozen_string_literal: true

require "test_helper"

class TestGitFonkyRepositories < Minitest::Test
  ENV["GFONK_REPOS"] = "repo1,repo2:staging"

  def test_parsing_env_var_returns_a_hash_where_key_is_repo_name_and_value_is_optional_branch_name_or_nil
    repo_hash = GitFonky::Repositories.parse_env

    assert_equal({repo1: nil, repo2: "staging"}, repo_hash)
  end
end
