require 'git'
require 'logger'
require 'octokit'
require 'httparty'
require_relative 'config'
require_relative 'commenter'
require_relative 'repository'
require_relative 'merger'
require_relative 'rebaser'

module FightClub
  class Arena
    def initialize(base_pull, config = FightClub.config)
      @base_pull = base_pull
    end

    def start
      Repository.new.update(FightClub.config.uri, FightClub.config.repo_name)

      git.checkout("origin/#{base_pull["head"]["ref"]}")

      return unless base_pull["base"]["ref"] == FightClub.config.master_branch

      return unless Rebaser.attempt_rebase(base_pull)

      git.reset_hard("origin/#{base_pull["head"]["ref"]}")

      pull_requests = client.pull_requests(FightClub.config.repo, :per_page => 200)

      pull_requests.each do |pr|
        Merger.new(base_pull, pr, git).execute
      end

      true
    end

    private

    attr_reader :base_pull, :client, :git

    def client
      @client = Octokit::Client.new(access_token: FightClub.config.oauth)
    end

    def git
      @git ||= Git.open("#{FightClub::WORKING_DIR}/#{FightClub.config.repo_name}", log: Logger.new(STDOUT))
    end
  end
end
