module GitFonky
  class Command
    attr_accessor :branch_name

    def initialize(branch_name = nil)
      @branch_name = branch_name
    end

    def current_branch
      `git branch --show-current`.strip
    end

    def fetch_upstream
      `git fetch upstream #{branch_name} 2>&1`
    end

    def pull_upstream
      `git pull upstream #{branch_name} 2>&1`
    end

    def push_to_origin
      `git push origin #{branch_name} 2>&1`
    end
  end
end
