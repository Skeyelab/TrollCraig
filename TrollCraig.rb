require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

######
# Pull settings from the .env file.
######
Dotenv.load
@graph = Koala::Facebook::API.new(ENV["FB_TOKEN"], ENV["APP_SECRET"])


today = Xmlstats.mlb_standing
today.each do |team|
  if team.last_name == "Cardinals"
    # message = "@[#{ENV['CL_ID']}] Test"
    # arguments_hash = {}
    # arguments_hash["message"] = message

    # @graph.rest_call("publish", arguments_hash)
    @graph.put_wall_post("Today the Cardinals are #{team.games_back} games back!")
  end
end
