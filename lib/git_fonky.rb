# frozen_string_literal: true

require_relative "git_fonky/version"
require_relative "git_fonky/repo_dir"
require_relative "git_fonky/repo_names"

module GitFonky
  class Error < StandardError; end

  GFONK_DIR = ENV["GFONK_DIR"] || "#{Dir.home}/code"

  def self.sync_repos
    Dir.chdir(GFONK_DIR)do
      REPO_NAMES.each do |dir|
        RepoDir.sync(dir)
        puts "\n" * 3
      end
    end
  end
end
