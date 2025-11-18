# frozen_string_literal: true

require_relative "reporter"

module GitFonky
  class RepoDirectory
    def self.sync(repo_config)
      Dir.chdir(repo_config[:repo].to_s) do
        new(repo_config).sync
      end
    end

    def initialize(repo_config, reporter: Reporter)
      @repo = repo_config[:repo]
      @branch = repo_config[:branch] || "main"
      @origin_remote = repo_config[:origin_remote] || "origin"
      @fork_remote = repo_config[:fork_remote] || "fork"
      @reporter = reporter.new(@repo, @branch)
    end

    def sync
      catch(:skip_repo) do
        announce_sync_attempt
        pull
        push
        announce_sync_success
      end
    end

    private

    def announce_sync_attempt
      @reporter.announce_sync_attempt
    end

    def pull
      `git pull #{@origin_remote} #{@branch} 2>&1`
      process_successful? ? @reporter.announce("pulled", "from", "#{@origin_remote}") : throw(:skip_repo, @reporter.failed_pull_msg)
    end

    def push
      `git push #{@fork_remote} #{@branch} 2>&1`
      process_successful? ? @reporter.announce("pushed", "to", "#{@fork_remote}") : throw(:skip_repo, @reporter.failed_push_msg)
    end

    def announce_sync_success
      @reporter.announce_sync_success
    end

    def process_successful?
      $?.success?
    end
  end
end
