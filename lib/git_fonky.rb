# frozen_string_literal: true

require_relative "git_fonky/version"
require_relative "git_fonky/repo_dir"
require_relative "git_fonky/repo_names"

module GitFonky
  class Error < StandardError; end

  def self.sync_repos
    Dir.chdir "#{Dir.home}/code" do
      REPO_NAMES.each do |dir|
        RepoDir.sync(dir)
        puts "\n\n\n"
      end
    end
  end
end
