# frozen_string_literal: true

require "colorize"
require_relative "git_fonky/version"
require_relative "git_fonky/repo_directory"
require_relative "git_fonky/parser"

module GitFonky
  class Error < StandardError; end

  GFONK_DIR = ENV["GFONK_DIR"] || "#{Dir.home}/code"

  def self.sync_repos
    Dir.chdir(GFONK_DIR) do
      Parser.parse_env.config.each do |repo_name, branch_name|
        RepoDirectory.sync(repo_name, branch_name)
        puts "\n" * 3
      end
    end

    puts "Process complete. See output for any errors or warnings."
    puts "DON'T FAKE THE FONK!"
  end
end
