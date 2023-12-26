require_relative "branch"
require_relative "command"
require_relative "reporter"

module GitFonky
  class RepoDir
    attr_reader :branch, :command, :dirname, :reporter

    def initialize(dirname, command = Command, branch = Branch, reporter = Reporter)
      @dirname = dirname
      @command = command.new
      @branch = branch.new(@command.current_branch)
      @command.branch_name = @branch.name
      @reporter = reporter.new(@dirname, @branch.name)
    end

    def self.sync(dirname)
      Dir.chdir(dirname) do
        new(dirname).sync
      end
    end

    def sync
      catch(:skip_repo) do
        announce_sync_attempt
        fetch
        pull
        push
        announce_sync_success
      end
    end

    private

    def announce_sync_attempt
      branch.valid? ? reporter.announce_sync_attempt : throw(:skip_repo, reporter.invalid_branch_msg)
    end

    def fetch
      command.fetch_upstream
      process_successful? ? reporter.announce("fetched") : throw(:skip_repo, reporter.failed_fetch_msg)
    end

    def pull
      command.pull_upstream
      process_successful? ? reporter.announce("pulled") : throw(:skip_repo, reporter.failed_pull_msg)
    end

    def push
      command.push_to_origin
      process_successful? ? reporter.announce("pushed", "to", "origin") : throw(:skip_repo, reporter.failed_push_msg)
    end

    def announce_sync_success
      reporter.announce_sync_success
    end

    def process_successful?
      $?.success?
    end
  end
end
