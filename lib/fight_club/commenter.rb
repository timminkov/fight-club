module FightClub
  class Commenter
    def self.comment(pr, message)
      HTTParty.post(
        pr["_links"]["comments"]["href"],
        body: {
          body: message,
        }.to_json,
        headers: {
          'Content-Type' => 'application/json',
          'User-Agent' => 'ruby',
          "Authorization" => "token #{FightClub.config.oauth}"
        }
      )

      Logger.new(STDOUT).info "Left a comment on #{pr["number"]} with message: #{message}"
    end
  end
end
