# Speedflow

[![Build Status](https://travis-ci.org/JulienBreux/speedflow.svg?branch=master)](https://travis-ci.org/JulienBreux/speedflow)
[![Gem Version](https://badge.fury.io/rb/speedflow.svg)](https://badge.fury.io/rb/speedflow)
[![Code Climate](https://codeclimate.com/github/JulienBreux/speedflow/badges/gpa.svg)](https://codeclimate.com/github/JulienBreux/speedflow)
[![Test Coverage](https://codeclimate.com/github/JulienBreux/speedflow/badges/coverage.svg)](https://codeclimate.com/github/JulienBreux/speedflow/coverage)
[![Inline docs](http://inch-ci.org/github/JulienBreux/speedflow.svg?branch=master)](http://inch-ci.org/github/JulienBreux/speedflow)

## Description

Welcome to Speedflow.
Speedflow was designed to ease the hard workflow and help you to keep your time.
Speedflow provides a robust system to transform your painful workflow in a sweet workflow.

## Installation

    $ gem install speedflow

## Usage

### Initialize your flow

    $ speedflow init

or

    $ sf i

### New issue

    $ speedflow new --title="My crazy new issue"

or

    $ sf n -t "My crazy new issue"

## List of adapters

### Project Manager adapters

- [Jira](https://www.atlassian.com/software/jira)

### Service control manager adapters

- [Git](https://git-scm.com/)

### Version control system adapters

- [GitHub](https://github.com/)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JulienBreux/speedflow. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## The Core Speedflow Team

* [Julien Breux](https://github.com/JulienBreux) - Author

_For a list of people who have contributed to the codebase, see [GitHub's list of contributors](https://github.com/JulienBreux/speedflow/contributors)._

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
