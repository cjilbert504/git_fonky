module GitFonky
  class RepoDir
    attr_reader :dirname

    def initialize(dirname)
      @dirname = dirname
    end

    def branch
      @branch ||= `git branch --show-current`.strip
    end

    def sync
      Dir.chdir dirname do
        announce_update
        return invalid_branch_msg if on_invalid_branch?

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

    def invalid_branch_msg
      msg = "You are not on the main/master branch. Please checkout the main/master branch and try again."
      sub_msg = "-----> skipping #{dirname} | #{branch} branch <-----"
      border = calculate_border_for(msg, "*")

      output_border_and_msg(border, msg, sub_msg)
    end

    private

    def failed_pull_msg
      msg = "-----> Failed to pull upstream #{branch}. Moving on to next repo. <-----"
      border = calculate_border_for(msg, "*")

      output_border_and_msg(border, msg)
    end

    def announce_update
      msg = "Updating -> #{dirname} | #{branch} branch "
      border = calculate_border_for(msg, "=")

      output_border_and_msg(border, msg, warn: false)
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

    def warning_header
      "WARNING"
    end

    def calculate_border_for(msg, border_char)
      border_char * (msg.length + 20)
    end

    def output_border_and_msg(border, msg, sub_msg = nil, warn: true)
      puts border
      puts warning_header.center(border.length) if warn
      puts sub_msg.center(border.length) if sub_msg
      puts msg.center(border.length)
      puts border
    end
  end
end
