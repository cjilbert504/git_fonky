# frozen_string_literal: true

require "colorize"

module GitFonky
  class Reporter
    def initialize(repo, branch)
      @repo = repo
      @branch = branch
    end

    def announce_sync_attempt
      report("Attempting to sync -> #{@repo} | #{@branch} branch", heading: true)
    end

    def announce(action, direction, remote)
      report("-----> #{action.capitalize} #{direction} #{remote} #{@branch}")
    end

    def announce_sync_success
      report("-----> Successfully synced #{@repo} | #{@branch} branch")
    end

    def invalid_branch_msg
      report("Failed to validate upstream #{@branch}.")
    end

    def failed_pull_msg
      "#{"WARNING".blink}: Failed to pull from upstream #{@branch}. Moving on to next repo.".yellow
    end

    def failed_push_msg
      "#{"WARNING".blink}: Failed to push to origin #{@branch}. Moving on to next repo.".yellow
    end

    private

    def report(msg, heading: false)
      puts heading ? msg.underline : msg.green
    end
  end
end
