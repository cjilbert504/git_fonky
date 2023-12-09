require_relative "reporter"
require_relative "command"

module GitFonky
  class RepoDir
    attr_reader :command, :dirname, :reporter

    def initialize(dirname)
      @command = Command.new(self)
      @dirname = dirname
      @reporter = Reporter.new(self)
    end

    def branch
      @branch ||= `git branch --show-current`.strip
    end

    def sync
      Dir.chdir dirname do
        reporter.announce_update
        return reporter.invalid_branch_msg if on_invalid_branch?

        command.fetch_upstream
        command.pull_upstream

        return failed_pull_msg unless $?.success?

        command.push_to_origin
        announce_success
      end
    end

    def on_invalid_branch?
      !branch.match?(/(main|master)/)
    end

    private

    def failed_pull_msg
      msg = "-----> Failed to pull upstream #{branch}. Moving on to next repo. <-----"
      border = calculate_border_for(msg, "*")

      output_border_and_msg(border, msg)
    end

    def announce_success
      puts "-----> Successfully updated #{dirname} | #{branch} branch"
    end
  end
end
