# frozen_string_literal: true

require_relative "message_formatter"

module GitFonky
  class Reporter
    def initialize(repo, branch, formatter = MessageFormatter)
      @repo = repo
      @branch = branch
      @formatter = formatter.new
    end

    def announce_sync_attempt
      msg = "Attempting to sync -> #{@repo} | #{@branch} branch"
      @formatter.output_message(msg, heading: true, warning: false)
    end

    def announce(action, direction, remote)
      msg = "-----> #{action.capitalize} #{direction} #{remote} #{@branch}"
      @formatter.output_message(msg, warning: false)
    end

    def announce_sync_success
      msg = "-----> Successfully synced #{@repo} | #{@branch} branch"
      @formatter.output_message(msg, warning: false)
    end

    def invalid_branch_msg
      msg = "Failed to validate upstream #{@branch}."
      @formatter.output_message(msg)
    end

    def failed_pull_msg
      msg = "Failed to pull from upstream #{@branch}."
      @formatter.output_message(msg)
    end

    def failed_push_msg
      msg = "Failed to push to origin #{@branch}."
      @formatter.output_message(msg)
    end
  end
end
