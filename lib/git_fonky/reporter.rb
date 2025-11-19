# frozen_string_literal: true

module GitFonky
  class Reporter
    def initialize(repo, branch)
      @repo = repo
      @branch = branch
    end

    def announce_sync_attempt
      report("Attempting to sync -> #{@repo} | #{@branch} branch", heading: true)
    end

    def announce(action, direction = "from", remote = "upstream")
      report("-----> #{action.capitalize} #{direction} #{remote} #{@branch}")
    end

    def announce_sync_success
      report("-----> Successfully synced #{@repo} | #{@branch} branch")
    end

    def failed_pull_msg
      "#{'WARNING'.blink}: Failed to pull from upstream #{@branch}.".yellow
    end

    def failed_push_msg
      "#{'WARNING'.blink}: Failed to push to origin #{@branch}.".yellow
    end

    private

    def report(msg, heading: false)
      puts heading ? msg.underline : msg.green
    end
  end
end
