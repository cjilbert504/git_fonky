# frozen_string_literal: true

require_relative "message_formatter"

module GitFonky
  class Reporter
    def initialize(repo_name, branch_name, formatter = MessageFormatter)
      @repo_name = repo_name
      @branch_name = branch_name
      @formatter = formatter.new
    end

    def announce_sync_attempt
      msg = "Attempting to sync -> #{@repo_name} | #{@branch_name} branch"
      @formatter.output_message(msg, heading: true, warning: false)
    end

    def announce(action, direction = "from", remote = "upstream")
      msg = "-----> #{action.capitalize} #{direction} #{remote} #{@branch_name}"
      @formatter.output_message(msg, warning: false)
    end

    def announce_sync_success
      msg = "-----> Successfully synced #{@repo_name} | #{@branch_name} branch"
      @formatter.output_message(msg, warning: false)
    end

    def invalid_branch_msg
      msg = "Failed to validate upstream #{@branch_name}."
      @formatter.output_message(msg)
    end

    def failed_pull_msg
      msg = "Failed to pull from upstream #{@branch_name}."
      @formatter.output_message(msg)
    end

    def failed_push_msg
      msg = "Failed to push to origin #{@branch_name}."
      @formatter.output_message(msg)
    end
  end
end
