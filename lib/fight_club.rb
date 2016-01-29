require_relative "fight_club/version"
require_relative "fight_club/arena"
require_relative "fight_club/config"

module FightClub
  class << self
    attr_writer :config
  end

  def self.begin(pull_request)
    Arena.new(pull_request).start
  end

  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield(config)
  end

  def self.working_dir
    "#{FightClub.config.repos_directory}/repos"
  end

  def self.git_command
    "git '--git-dir=#{working_dir}/#{config.repo_name}/.git' '--work-tree=#{working_dir}/#{config.repo_name}'"
  end
end
