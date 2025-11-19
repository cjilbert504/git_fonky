# frozen_string_literal: true

require "open3"
require_relative "reporter"

module GitFonky
  class Repository
    def initialize(repo:, branch: "main", origin_remote: "origin", fork_remote: "fork", reporter: Reporter)
      @repo = repo
      @branch = branch
      @origin_remote = origin_remote
      @fork_remote = fork_remote
      @reporter = reporter.new(@repo, @branch)
    end

    def sync
      Dir.chdir(@repo.to_s) do
        @reporter.announce_sync_attempt
        attempt_pull
        attempt_push
        @reporter.announce_sync_success
        true
      rescue PullError, PushError => exception
        warn exception.message
        false
      end
    end

    private

    def attempt_pull
      _stdout, _stderr, status = Open3.capture3("git", "pull", @origin_remote, @branch)

      if status.success?
        @reporter.announce("pulled", "from", @origin_remote.to_s)
      else
        raise PullError, @reporter.failed_pull_msg
      end
    end

    def attempt_push
      _stdout, _stderr, status = Open3.capture3("git", "push", @fork_remote, @branch)

      if status.success?
        @reporter.announce("pushed", "to", @fork_remote.to_s)
      else
        raise PushError, @reporter.failed_push_msg
      end
    end
  end
end
