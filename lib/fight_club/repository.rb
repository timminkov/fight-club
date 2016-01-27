module FightClub
  class Repository
    WORKING_DIR = "#{Dir.pwd}/repos"

    def update(uri, name)
      system("mkdir #{WORKING_DIR}/#{name}") unless Dir.exists? "WORKING_DIR/#{name}"

      git = Git.open("#{WORKING_DIR}/#{name}", :log => Logger.new(STDOUT))

      unless File.exists?("#{WORKING_DIR}/#{name}/.gitconfig")
        Logger.new(STDOUT).info "Cloning #{name}..."

        git.clone(uri, name, :path => WORKING_DIR)
      end

      git.fetch
    end
  end
end
