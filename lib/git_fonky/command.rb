module GitFonky
  class Command
    attr_reader :repo_dir

    def initialize(repo_dir)
      @repo_dir = repo_dir
    end

    def fetch_upstream
      announce("fetching")
      `git fetch upstream #{repo_dir.branch} 2>&1`
    end

    def pull_upstream
      announce("pulling")
      `git pull upstream #{repo_dir.branch} 2>&1`
    end

    def push_to_origin
      announce("pushing", "to", "origin")
      `git push origin #{repo_dir.branch} 2>&1`
    end

    private

    def announce(action, direction = "from", remote = "upstream")
      puts "-----> #{action} #{direction} #{remote} #{repo_dir.branch}"
    end
  end
end
