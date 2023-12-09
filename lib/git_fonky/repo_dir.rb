require_relative "reporter"

module GitFonky
  class RepoDir
    attr_reader :dirname, :reporter

    def initialize(dirname)
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

        fetch_upstream
        pull_upstream

        return failed_pull_msg unless $?.success?

        push_to_origin
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

    def announce(action, direction = "from", remote = "upstream")
      puts "-----> #{action} #{direction} #{remote} #{branch}"
    end

    def fetch_upstream
      announce("fetching")
      `git fetch upstream #{branch} 2>&1`
    end

    def pull_upstream
      announce("pulling")
      `git pull upstream #{branch} 2>&1`
    end

    def push_to_origin
      announce("pushing", "to", "origin")
      `git push origin #{branch} 2>&1`
    end
  end
end
