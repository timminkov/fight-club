# FightClub
![FightClub]
(http://i.imgur.com/sQJNhBi.gif)

Fight Club will notify users of pull requests of any conflicts against other open pull requests.

## Installation

Add this line to your application's Gemfile:

    gem 'fight-club'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fight-club

## Configuration

Add the following to an initializer in your codebase (`config/initializers/fight_club.rb` in Rails):

```ruby
FightClub.configure do |config|
  config.repo = 'baxterthehacker/public-repo' # the repo with org/user name
  config.oauth = '12345678901234567890abcdef' # your oauth token
  config.repo_name = 'public-repo' # the repo name alone
  config.uri = 'git@github.com:baxterthehacker/public-repo.git' # the URI to use to clone the repo
  config.master_branch = 'master' # what branch to run fight club against
end
```

## Usage

Add this to your code:

```ruby
FightClub.begin(pull_request)
```

Where `pull_request` looks like a payload from a [Github webhook](https://developer.github.com/v3/pulls/).

## Why?

Sometimes you want to move fast! It's annoying to have conflicts with a master branch after another branch gets merged.
