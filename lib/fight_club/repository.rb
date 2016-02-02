module FightClub
  class Repository
    def update(uri, name, working_dir, git)
      system("mkdir -p #{working_dir}/#{name}") unless Dir.exists? "#{working_dir}/#{name}"

      unless File.exists?("#{working_dir}/#{name}/.gitconfig")
        git.clone(uri)
        Logger.new(STDOUT).info "Clone complete!"
      end

      git.fetch
    end
  end
end
