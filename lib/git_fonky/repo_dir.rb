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
      announce_update
      fetch_upstream
      pull_upstream
      if $?.success?
        push_to_origin
      else
        failed_pull_msg
      end
      puts "\n\n"
    end

    def on_invalid_branch?
      !branch.match?(/(main|master)/)
    end

    def invalid_branch_msg
      msg = "You are not on the main/master branch. Please checkout the main/master branch and try again."
      sub_msg = "-----> skipping #{dirname} | #{branch} branch <-----"
      border = border_for(msg, "*")

      puts border
      puts warning_header.center(border.length)
      puts msg.center(border.length)
      puts sub_msg.center(border.length)
      puts border
    end

    private

    def failed_pull_msg
      msg = "-----> Failed to pull upstream #{branch}. Moving on to next repo. <-----"
      border = border_for(msg, "*")

      puts border
      puts warning_header.center(border.length)
      puts msg.center(border.length)
      puts border
    end

    def announce_update
      update_msg = "Updating -> #{dirname} | #{branch} branch "
      puts "=" * update_msg.length
      puts update_msg
      puts "=" * update_msg.length
    end

    def announce(action, direction = "from", remote = "upstream")
      puts "-----> #{action} #{direction} #{remote} #{branch}"
    end

    def fetch_upstream
      # announce("fetching")
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

    def border_for(msg, border_char)
      border_char * (msg.length + 20)
    end
  end
end
