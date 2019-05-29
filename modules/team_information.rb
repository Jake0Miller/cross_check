module TeamInformation
  def find_games_by_team_id(team_id, games = @games)
    games.find_all do |game|
      game[1].away_team_id == team_id || game[1].home_team_id == team_id
    end
  end

  def games_by_season(team_id)
    find_games_by_team_id(team_id).group_by do |game|
      game[1].season
    end
  end

  def won_at_home?(team_id,game)
    game.home_team_id == team_id && game.home_goals > game.away_goals
  end

  def won_away?(team_id,game)
    game.away_team_id == team_id && game.home_goals < game.away_goals
  end

  def win_percent_by_season(team_id)
    games_by_season(team_id).each_with_object({}) do |season,hash|
      hash[season[0]] = percent_wins(team_id,season[1])
    end
  end

  def percent_wins(team_id,games)
    wins = games.count do |game|
      won_at_home?(team_id,game[1]) || won_away?(team_id,game[1])
    end
    (wins.to_f/games.length).round(2)
  end

  def our_score(team_id, game)
    if team_id == game.home_team_id
      game.home_goals
    else
      game.away_goals
    end
  end

  def win_percent_by_team_hash(our_team_id,games)
    @teams.each_with_object({}) do |team,hash|
      if team[1].team_id != our_team_id
        this_teams_games = find_games_by_team_id(team[1].team_id, games)
        this_teams_wins = percent_wins(our_team_id, this_teams_games)
        hash[team[1].team_name] = this_teams_wins
      end
    end
  end

  def win_percent(team_id,games,type)
    avg = percent_wins(team_id,games.find_all {|game| game[1].type == type})
    avg.nan? ? 0.0 : avg
  end

  def scored(team_id,games,type)
    games = games.find_all {|game| game[1].type == type}
    games.sum {|game| our_score(team_id,game[1])}
  end

  def against(team_id,games,type)
    games = games.find_all {|game| game[1].type == type}
    games.sum {|game| their_score(team_id,game[1])}
  end

  def their_score(team_id, game)
    if team_id != game.home_team_id
      game.home_goals
    else
      game.away_goals
    end
  end

  def avg_scored(team_id,games,type)
    games = games.find_all {|game| game[1].type == type}
    total = (games.sum {|game| our_score(team_id,game[1])}/games.length.to_f).round(2)
    total.nan? ? 0.0 : total
  end

  def avg_against(team_id,games,type)
    games = games.find_all {|game| game[1].type == type}
    total = (games.sum {|game| their_score(team_id,game[1])}/games.length.to_f).round(2)
    total.nan? ? 0.0 : total
  end

  def find_all_wins(team_id)
    find_games_by_team_id(team_id, games).map do |game|
      if won_at_home?(team_id,game[1]) || won_away?(team_id,game[1])
        (game[1].home_goals - game[1].away_goals).abs
      end
    end.find_all do |game|
      !game.nil?
    end
  end

  def find_all_losses(team_id)
    find_games_by_team_id(team_id).map do |game|
      if !won_at_home?(team_id, game[1]) && !won_away?(team_id, game[1])
        (game[1].home_goals - game[1].away_goals).abs
      end
    end.find_all do |game|
      !game.nil?
    end
  end

  def summary(id,season,type)
    {win_percentage: win_percent(id,season,type),
    total_goals_scored: scored(id,season,type),
    total_goals_against: against(id,season,type),
    average_goals_scored: avg_scored(id,season,type),
    average_goals_against: avg_against(id,season,type)}
  end
end
