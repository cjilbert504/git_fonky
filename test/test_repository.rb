# frozen_string_literal: true

require "test_helper"

class RepositoryTest < Minitest::Test
  class DummyReporter
    attr_reader :repo, :branch
    def initialize(repo, branch)
      @repo = repo
      @branch = branch
    end
  end

  def test_initializes_with_all_arguments
    repo = GitFonky::Repository.new(
      repo: "myrepo",
      branch: "dev",
      origin_remote: "upstream",
      fork_remote: "myfork",
      reporter: DummyReporter
    )
    assert_equal "myrepo", repo.instance_variable_get(:@repo)
    assert_equal "dev", repo.instance_variable_get(:@branch)
    assert_equal "upstream", repo.instance_variable_get(:@origin_remote)
    assert_equal "myfork", repo.instance_variable_get(:@fork_remote)
    reporter = repo.instance_variable_get(:@reporter)
    assert_instance_of DummyReporter, reporter
    assert_equal "myrepo", reporter.repo
    assert_equal "dev", reporter.branch
  end

  def test_defaults_are_used
    repo = GitFonky::Repository.new(repo: "myrepo", reporter: DummyReporter)
    assert_equal "main", repo.instance_variable_get(:@branch)
    assert_equal "origin", repo.instance_variable_get(:@origin_remote)
    assert_equal "fork", repo.instance_variable_get(:@fork_remote)
  end

  def test_missing_required_argument_raises
    assert_raises(ArgumentError) do
      GitFonky::Repository.new(reporter: DummyReporter)
    end
  end
end
