module FightClub
  class Rebaser
    def self.attempt_rebase(pr)
      result = `#{FightClub.git_command} rebase origin/#{FightClub.config.master_branch}`

      if result.include? 'CONFLICT'
        Commenter.comment(pr, 'Your branch is currently conflicting with the target branch. Please resolve all merge conflicts and repush.')
        `#{FightClub.git_command} rebase --abort`

        return false
      end

      true
    end
  end
end
