module FightClub
  class Repository
    def update(uri, name)
      system("mkdir -p #{FightClub.working_dir}/#{name}") unless Dir.exists? "#{FightClub.working_dir}/#{name}"

      git = Git.open("#{FightClub.working_dir}/#{name}", :log => Logger.new(STDOUT))

      unless File.exists?("#{FightClub.working_dir}/#{name}/.gitconfig")
        Logger.new(STDOUT).info "Cloning #{name}..."

        git.clone(uri, name, :path => FightClub.working_dir)
      end

      git.fetch
    end
  end
end
