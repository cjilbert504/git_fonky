# GitFonky

Time to GitFonky! What do we do here you ask? Well, if you're like us, you have numerous repositories that you work on with others and keeping them all up-to-date can be a real drag.
That's where we come in with the funk! We take care of pulling in all the latest code for each repository you tell us by running one command!

## Installation

`gem install git_fonky`

## Usage

GitFonky uses two environment variables in order to do its thing - `GFONK_DIR` and `GFONK_REPOS`.

### `GFONK_DIR`

Set this environment variable if you wish to override the default directory that GitFonky uses to look for your repositories within. If you do not set this
environment variable then the defualt is to use the current users HOME directory and then a directory called `/code`. This is would be something like `/Users/somebody/code` done via `"#{Dir.home}/code`.

If you set the `GFONK_DIR` environment variable you should set it to the path to the directory that contains all of the repositories you want to
stop faking the funk with.

### GFONK_REPOS

This environment variable must be set if you want any funk to happen! The value of this environment variable should be a string of repository names separated
only by commas (NO SPACES!):
```bash
export GFONK_REPOS="repo1,repo2,repo3"
```

You can also specify a branch to use with a given repository. To specify the branch add a colon after the repository
name followed by the name of the branch.
```bash
export GFONK_REPOS="repo1,repo2:main,repo3:staging"
```

If you do not specify a branch for a repository then whatever the current branch is that you are on in a given
repository directory is the branch that will be used to attempt to sync the repository between the remotes.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on the [GitHub page](https://github.com/cjilbert504/git_fonky.) for the gem.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
