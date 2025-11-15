module GitFonky
  class Repositories
    def self.parse_env
      new.parse_gfonk_repos_env_var
    rescue NoMethodError
      warn "The $GFONK_REPOS environment variable is not properly set."
      warn "Please set the variable to point to a string list of repository names separated only by commas (NO SPACES)."
      warn "You can optionally specify the branch name to use for a given repository by separating the repository and branch names with a colon."
      warn "EXAMPLE:"
      warn "export GFONK_REPOS='repo1,repo2,repo3:branch_name'"
      exit 1
    end

    def parse_gfonk_repos_env_var
      ENV["GFONK_REPOS"].split(",").map { |repo_config| repo_config.split(":") }.map do |repo_name, branch_name|
        if branch_name.nil?
          [repo_name.to_sym, nil]
        else
          [repo_name.to_sym, branch_name]
        end
      end.to_h
    end
  end
end
