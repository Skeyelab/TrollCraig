require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
Dotenv.load
@graph = Koala::Facebook::API.new(ENV["FB_TOKEN"], ENV["APP_SECRET"])

today = Xmlstats.mlb_standing

stats = {}

today.each do |team|

  case team.last_name
  when "Cubs"
    stats["cubs_rank"] = team.ordinal_rank
    stats["games_played"] = team.games_played
    stats["cubs_won"] = team.won
    stats["cubs_lost"] = team.lost
  when "Cardinals"
    stats["cards_games_back"] = team.games_back
  end

end

message = "Today the Cardinals are #{stats['cards_games_back']} games back. The Cubs are still in #{stats['cubs_rank']} place with a record of #{stats['cubs_won']} wins and #{stats['cubs_lost']} losses!"

if stats["cubs_rank"] == "1st"
  @graph.put_wall_post(message)
  puts "Posted: #{message}"
end
