module FightClub
  class Merger
    def initialize(base_pull, pr, git)
      @base_pull = base_pull
      @pr = pr
      @git = git
    end

    def execute
      Logger.new(STDOUT).info "Trying to merge #{pr.head.ref} into #{base_pull["head"]["ref"]}..."
      return unless pr.base.ref == FightClub.config.master_branch
      return if pr.head.ref == base_pull["head"]["ref"]

      git.reset_hard("origin/#{base_pull["head"]["ref"]}")
      git.checkout("origin/#{pr.head.ref}")
      return unless Rebaser.attempt_rebase(pr)

      git.checkout("origin/#{base_pull["head"]["ref"]}")

      unless attempt_merge(pr)
        Commenter.comment(pr, "Your branch currently conflicts with another open pull request: #{base_pull["_links"]["html"]["href"]}")
        Commenter.comment(base_pull, "Your branch currently conflicts with another open pull request: #{pr._links.html.href}")
      end
    end

    def attempt_merge(pr)
      result = `#{FightClub.git_command} merge origin/#{pr.head.ref}`

      !(result.include? 'CONFLICT')
    end

    private

    attr_reader :base_pull, :pr, :git
  end
end
