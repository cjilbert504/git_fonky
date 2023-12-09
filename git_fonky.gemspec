# frozen_string_literal: true

require_relative "lib/git_fonky/version"

Gem::Specification.new do |spec|
  spec.name = "git_fonky"
  spec.version = GitFonky::VERSION
  spec.authors = ["Collin Jilbert"]
  spec.email = ["cjilbert504@gmail.com"]

  spec.summary = "Sync all of your git repos with one command."
  spec.description = "Do 'em all at once."
  spec.homepage = "https://github.com/cjilbert504/git_fonky"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/cjilbert504/git_fonky"
  spec.metadata["changelog_uri"] = "https://github.com/cjilbert504/git_fonky/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
