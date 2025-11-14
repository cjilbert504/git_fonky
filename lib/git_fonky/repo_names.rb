module GitFonky

  begin
    REPO_NAMES = ENV["GFONK_REPOS"].split(",")
  rescue NoMethodError
    puts "The $GFONK_REPOS environment variable is not set."
    puts "Please set the variable to point to a string list of repository names separated only by commas (NO SPACES):"
    puts "export GFONK_REPOS='repo1,repo2,repo3'"
    exit 1
  end
end
