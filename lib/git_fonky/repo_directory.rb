# frozen_string_literal: true

require_relative "command"
require_relative "reporter"

module GitFonky
  class RepoDirectory
    def initialize(repo_name = nil, branch = nil, command: Command, reporter: Reporter)
      @repo_name = repo_name
      @command = command.new
      @branch = branch || get_current_branch
      @command.branch_name = @branch
      @reporter = reporter.new(@repo_name, @branch)
    end

    def self.sync(repo_name, branch_name)
      Dir.chdir(repo_name.to_s) do
        new(repo_name, branch_name).sync
      end
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

    def get_current_branch
      @command.current_branch
    end

    def announce_sync_attempt
      @reporter.announce_sync_attempt
    end

    def pull
      @command.pull_upstream
      process_successful? ? @reporter.announce("pulled") : throw(:skip_repo, @reporter.failed_pull_msg)
    end

    def push
      @command.push_to_origin
      process_successful? ? @reporter.announce("pushed", "to", "origin") : throw(:skip_repo, @reporter.failed_push_msg)
    end

    def announce_sync_success
      @reporter.announce_sync_success
    end

    def process_successful?
      $?.success?
    end
  end
end
