# frozen_string_literal: true

module GitFonky
  class Parser
    def self.parse_env
      new.parse_gfonk_repos_env_var
    rescue NoMethodError
      warn "The $GFONK_REPOS environment variable is not properly set."
      warn "Please set the variable to point to a string list of repository names separated only by commas (NO SPACES)."
      warn "You can optionally specify the branch, origin remote and fork remote to use for a given repository by separating each with a colon."
      warn "EXAMPLE:"
      warn "export GFONK_REPOS='repo1,repo2:branch,repo3:branch_name:origin_remote_name:fork_remote_name'"
      exit 1
    end

    def parse_gfonk_repos_env_var
      keys = [:repo, :branch, :origin_remote, :fork_remote]

      split_repo_details.each_with_index.to_h do |values, index|
        [index, keys.zip(values).to_h]
      end
    end

    private

    def split_repo_details
      ENV["GFONK_REPOS"].split(",").map do |repo|
        repo.split(":")
      end
    end
  end
end
