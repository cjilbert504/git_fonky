module GitFonky
  class Command
    attr_reader :repo_dir, :reporter

    def initialize(repo_dir:, reporter:)
      @repo_dir = repo_dir
      @reporter = reporter
    end

    def current_branch
      `git branch --show-current`.strip
    end

    def fetch_upstream
      reporter.announce("fetching")
      `git fetch upstream #{repo_dir.branch} 2>&1`
    end

    def pull_upstream
      reporter.announce("pulling")
      `git pull upstream #{repo_dir.branch} 2>&1`
    end

    def push_to_origin
      reporter.announce("pushing", "to", "origin")
      `git push origin #{repo_dir.branch} 2>&1`
    end
  end
end
