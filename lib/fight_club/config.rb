module FightClub
  class Config
    attr_accessor :repo, :oauth, :repo_name,
      :uri, :master_branch, :repos_directory,
      :comment_check, :save_comment

    def initialize
      @repo = 'baxterthehacker/public-repo'
      @oauth = 'Not set'
      @repo_name = 'public-repo'
      @uri = 'git@github.com:baxterthehacker/public-repo.git'
      @master_branch = 'master'
      @repos_directory = '/tmp'
      @comment_check = Proc.new { |pr, comment| false }
      @save_comment = Proc.new { |pr, comment| false }
    end
  end
end
