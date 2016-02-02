module FightClub
  class Config
    attr_accessor :repo, :oauth, :repo_name,
      :uri, :master_branch, :repos_directory

    def initialize
      @repo = 'baxterthehacker/public-repo'
      @oauth = 'Not set'
      @repo_name = 'public-repo'
      @uri = 'git@github.com:baxterthehacker/public-repo.git'
      @master_branch = 'master'
      @repos_directory = '/tmp'
    end
  end
end
