module TeamInformation
  # def find_team(team_id)
  #   @teams[team_id.to_sym]
  # end
  #
  # def get_team_name_from_id(team_id)
  #   find_team(team_id).team_name
  # end

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

  def won_at_home?(team_id,game)
    game.home_team_id == team_id && game.home_goals > game.away_goals
  end

  def won_away?(team_id,game)
    game.away_team_id == team_id && game.home_goals < game.away_goals
  end

  def win_percent_by_season(team_id)
    wins_by_season = {}
    games_by_season(team_id).each do |season|
      wins_by_season[season.first] = percent_wins(team_id,season.last)
    end
    wins_by_season
  end

  def percent_wins(team_id,games)
    wins = games.count do |game|
      won_at_home?(team_id,game) || won_away?(team_id,game)
    end
    (100.0*wins/games.length).round(2)
  end

  def extreme_scores(team_id, game)
    if team_id == game.home_team_id
      game.home_goals
    else
      game.away_goals
    end
  end  
end
