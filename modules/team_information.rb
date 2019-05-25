module TeamInformation
  def find_games_by_team_id(team_id, games = @games)
    games.find_all do |game|
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
    (1.0*wins/games.length).round(2)
  end

  def extreme_scores(team_id, game)
    if team_id == game.home_team_id
      game.home_goals
    else
      game.away_goals
    end
  end

  def win_percent_by_team_hash(our_team_id,games)
    @teams.inject({}) do |hash,team|
      if team[1].team_id != our_team_id
        this_teams_games = find_games_by_team_id(team[1].team_id, games)
        this_teams_wins = percent_wins(our_team_id, this_teams_games)
        hash[team[1].team_name] = this_teams_wins
      end
      hash
    end
  end
end
