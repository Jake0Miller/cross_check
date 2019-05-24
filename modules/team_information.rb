#this module works with team_stats
require "pry"
module TeamInformation

  def find_team(team_id)
    #binding.pry
    @teams[team_id.to_sym]
  end

  def get_team_name_from_id(team_id)
    find_team(team_id).team_name
  end

  def find_games_by_team_id(team_id)
    @games.find_all do |game|
      game.away_team_id == team_id || game.home_team_id == team_id
    end
  end

  def games_by_season(team_id)
    find_games_by_team_id(team_id).group_by do |game|
      game.season
    end
  end

  def home_won?(game)
    game.home_goals > game.away_goals
  end

  def away_won?(game)
    game.home_goals < game.away_goals
  end

  def win_percent_by_season(team_id)
    wins_by_season = {}
    games_by_season(team_id).each do |season|
      wins = 0
      season.last.each do |game|
        if team_id == game.home_team_id && home_won?(game)
          wins += 1
        elsif team_id == game.away_team_id && away_won?(game)
          wins += 1
        end
      end
      win_percent = (100.0*wins/season.last.length).round(2)
      wins_by_season[season.first] = win_percent
    end
    wins_by_season
  end
end
