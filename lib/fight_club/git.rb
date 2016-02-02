module FightClub
  class Git
    def initialize(directory, repo_name, logger = Logger.new(STDOUT))
      @logger = logger
      @directory = directory
      @repo_name = repo_name
    end

    def clone(target)
      run("git clone #{target} #{directory}/#{repo_name}")
    end

    def checkout(target)
      run("#{base_command} checkout #{target}")
    end

    def reset_hard(target)
      run("#{base_command} reset --hard #{target}")
    end

    def merge(target)
      run("#{base_command} merge -m 'merge' #{target}")
    end

    def merge_abort
      run("#{base_command} merge --abort")
    end

    def fetch
      run("#{base_command} fetch")
    end

    private

    attr_reader :logger, :directory, :repo_name

    def run(command)
      logger.info("Git executing: #{command}")

      `#{command}`
    end

    def base_command
      "git '--git-dir=#{directory}/#{repo_name}/.git' '--work-tree=#{directory}/#{repo_name}'"
    end
  end
end
