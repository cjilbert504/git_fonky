# frozen_string_literal: true

require_relative "git_fonky/version"
require_relative "git_fonky/repo_dir"
require_relative "git_fonky/work_repo_names"

module GitFonky
  class Error < StandardError; end

  def self.sync_repos
    Dir.chdir "#{Dir.home}/code" do
      WORK_REPO_NAMES.each do |dir|
        repo = RepoDir.new(dir)

        Dir.chdir repo.dirname do
          puts repo.dirname.upcase

          next repo.invalid_branch_msg if repo.on_invalid_branch?

          repo.sync
        end

        puts "\n\n"
      end
    end
  end
end
