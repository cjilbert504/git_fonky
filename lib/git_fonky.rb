# frozen_string_literal: true

require "colorize"
require_relative "git_fonky/version"
require_relative "git_fonky/repo_dir"
require_relative "git_fonky/repositories"

module GitFonky
  class Error < StandardError; end

  GFONK_DIR = ENV["GFONK_DIR"] || "#{Dir.home}/code"

  def self.sync_repos
    Dir.chdir(GFONK_DIR) do
      Repositories.parse_env.each do |repo, branch|
        RepoDir.sync(repo_name: repo, branch_name: branch)
        puts "\n" * 3
      end
    end

    puts "Process complete. See output for any errors or warnings."
    puts "DON'T FAKE THE FONK!"
  end
end
