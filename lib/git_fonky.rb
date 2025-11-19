# frozen_string_literal: true

require_relative "git_fonky/version"
require_relative "git_fonky/repository"
require_relative "git_fonky/parser"

module GitFonky
  class Error < StandardError; end
  class PullError < Error; end
  class PushError < Error; end

  GFONK_DIR = ENV["GFONK_DIR"] || "#{Dir.home}/code"

  def self.sync_repos
    Dir.chdir(GFONK_DIR) do
      Parser.parse_env.values.each do |repo_config|
        Repository.new(**repo_config.compact!).sync
        puts "\n" * 3
      end
    end

    puts "Process complete. See output for any errors or warnings."
    puts "DON'T FAKE THE FONK!"
  end
end
