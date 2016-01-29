module FightClub
  class Repository
    def update(uri, name)
      system("mkdir -p #{FightClub.working_dir}/#{name}") unless Dir.exists? "#{FightClub.working_dir}/#{name}"

      unless File.exists?("#{FightClub.working_dir}/#{name}/.gitconfig")
        Logger.new(STDOUT).info "Cloning using URI: #{uri} | Name: #{name} | Path: #{FightClub.working_dir}"
        git = Git.clone(uri, name, :path => FightClub.working_dir)
        Logger.new(STDOUT).info "Clone complete!"
      else
        git = Git.open("#{FightClub.working_dir}/#{name}", :log => Logger.new(STDOUT))
      end

      git.fetch
    end
  end
end
