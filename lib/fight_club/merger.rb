module FightClub
  class Merger
    def self.attempt_merge(pr, git)
      git.reset_hard("origin/#{pr["head"]["ref"]}")
      result = git.merge("origin/#{FightClub.config.master_branch}")

      if result.include? 'CONFLICT'
        Commenter.comment(pr, 'Your branch is currently conflicting with the target branch. Please resolve all merge conflicts and repush.')

        git.merge_abort

        return false
      end

      true
    end
  end
end
