require_relative "message_formatter"
module GitFonky
  class Reporter
    attr_reader :formatter, :repo_name, :repo_branch

    def initialize(repo_name, repo_branch, formatter = MessageFormatter)
      @repo_name = repo_name
      @repo_branch = repo_branch
      @formatter = formatter.new
    end

    def announce(action, direction = "from", remote = "upstream")
      STDERR.puts "-----> #{action} #{direction} #{remote} #{repo_branch}"
    end

    def announce_sync_success
      puts "-----> Successfully synced #{repo_name} | #{repo_branch} branch"
    end

    def announce_sync_attempt
      msg = "Attempting to sync -> #{repo_name} | #{repo_branch} branch "
      formatter.message_with_border(msg: msg, border_char: "=", warn: false)
    end

    def invalid_branch_msg
      msg = "You are not on the main/master branch. Please checkout the main/master branch and try again."
      sub_msg = "-----> skipping #{repo_name} | #{repo_branch} branch <-----"
      formatter.message_with_border(msg: msg, sub_msg: sub_msg)
    end

    def failed_fetch_msg
      msg = "-----> Failed to fetch from upstream #{repo_branch}. Moving on to next repo. <-----"
      formatter.message_with_border(msg: msg)
    end

    def failed_pull_msg
      msg = "-----> Failed to pull from upstream #{repo_branch}. Moving on to next repo. <-----"
      formatter.message_with_border(msg: msg)
    end

    def failed_push_msg
      msg = "-----> Failed to push to origin #{repo_branch}. Moving on to next repo. <-----"
      formatter.message_with_border(msg: msg)
    end

    def failed_sync_msg
      msg = "-----> Failed to sync #{repo_name} | #{repo_branch}. Moving on to next repo. <-----"
      formatter.message_with_border(msg: msg)
    end
  end
end
