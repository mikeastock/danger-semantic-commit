# Danger::SemanticCommit

[![Build Status](https://travis-ci.org/mikeastock/danger-semantic-commit.svg?branch=master)](https://travis-ci.org/mikeastock/danger-semantic-commit)

A Danger plugin that validates your commits to be semantic. Semantic commits
idea comes from the Karma Runner project. More information can be found
[here](http://karma-runner.github.io/1.0/dev/git-commit-msg.html)

## Installation

Add this line to your application's Gemfile:

```ruby
gem "danger-semantic-commit"
```

And then execute:

    $ bundle

## Usage

To use the default config simply add this line to your `Dangerfile`

```
semantic_config.validate
```

By default the plugin will fail any commits that don't pass the checks. To change
this you can pass a config like so:

```
semantic_commit.validate warn: :all
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mikeastock/danger-semantic-commit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

