require_relative "reporter"
require_relative "command"

module GitFonky
  class RepoDir
    attr_reader :command, :dirname, :reporter

    def initialize(dirname)
      @dirname = dirname
      @reporter = Reporter.new(self)
      @command = Command.new(repo_dir: self, reporter: reporter)
    end

    def branch
      @branch ||= command.current_branch
    end

    def sync
      Dir.chdir dirname do
        reporter.announce_update
        return reporter.invalid_branch_msg if on_invalid_branch?

        command.fetch_upstream
        command.pull_upstream

        return reporter.failed_pull_msg unless $?.success?

        command.push_to_origin
        reporter.announce_success
      end
    end

    def on_invalid_branch?
      !branch.match?(/(main|master)/)
    end
  end
end
