# Evertils::Common

[![Code Climate](https://codeclimate.com/github/aapis/evertils-common/badges/gpa.svg)](https://codeclimate.com/github/aapis/evertils-common) [![Build Status](https://travis-ci.org/aapis/evertils-common.svg?branch=master)](https://travis-ci.org/aapis/evertils-common)

Evertils::Common is an abstraction library for interacting with the Evernote API.

## Installation

```ruby
gem 'evertils-common'

# or from the command line
gem install evertils-common
```

Then add the following to your ~/.bash_profile

```shell
export EVERTILS_TOKEN="token_goes_here"

# add the following if you plan on running the test suite
export EVERTILS_SB_TOKEN="sandbox token here"
```

Get your production Evernote Developer Tokens [here](https://www.evernote.com/api/DeveloperToken.action) and your sandbox tokens [here](https://sandbox.evernote.com/api/DeveloperToken.action).

## Usage

Please see the code samples in the [wiki](https://github.com/aapis/evertils-common/wiki).

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aapis/evertils-common.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

