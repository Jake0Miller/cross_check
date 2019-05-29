module SeasonHelper
  def all_games_by_season(season_id)
    @games.find_all do |game|
      game[1].season == season_id
    end
  end

  def season_games_by_type(season_id)
    all_games_by_season(season_id).group_by do |game|
      game[1].type
    end
  end

  def season_game_teams(season_id,type)
    season_games_by_type(season_id)[type].each_with_object([]) do |game,array|
      array.push(@game_teams[game[0]])
    end
  end

  def season_by_team(season_id,type)
    season_game_teams(season_id,type).each_with_object({}) do |game_team,hash|
      hash[game_team.keys[0]] ||= []
      hash[game_team.keys[0]] << game_team.values[0]
      hash[game_team.keys[1]] ||= []
      hash[game_team.keys[1]] << game_team.values[1]
    end
  end

  def wins_by_team(season_id,type)
    season_by_team(season_id,type).each_with_object({}) do |game_team,hash|
      wins = game_team[1].count do |game|
        game.won == "TRUE"
      end
      hash[game_team[0]] = (wins / game_team[1].length.to_f).round(2)
    end
  end

  def post_reg_difference(season_id)
    reg_wins = wins_by_team(season_id,'R')
    post_wins = wins_by_team(season_id,'P')
    post_wins.each do |team|
      post_wins[team[0]] = team[1] - reg_wins[team[0]]
    end
    post_wins
  end

  def game_teams_by_season(season_id)
    all_games_by_season(season_id).each_with_object([]) do |game,array|
      array.push(@game_teams[game[0]].values)
    end.flatten
  end

  def game_teams_by_team(season_id)
    game_teams_by_season(season_id).group_by do |game_team|
      game_team.team_id
    end
  end

  def hits_by_team(season_id)
    game_teams_by_team(season_id).each_with_object({}) do |team,hash|
      hash[team[0]] = team[1].sum {|game| game.hits}
    end
  end

  def accurate_team(season_id)
    game_teams_by_team(season_id).each_with_object({}) do |team,hash|
      hash[team[0]] = team[1].each_with_object({shots: 0, goals: 0}) do |game,h|
        h[:shots] += game.shots
        h[:goals] += game.goals
      end
    end
  end

  def coach_info(season_id)
    game_teams_by_season(season_id).each_with_object({}) do |game,h|
      h[game.head_coach] ||= {wins: 0, games: 0}
      h[game.head_coach][:wins] += 1 if game.won == "TRUE"
      h[game.head_coach][:games] += 1
    end
  end

  def coach_win_percentage(season_id)
    coach_stats = coach_info(season_id)
    coach_stats.transform_values do |stat|
      stat[:wins].to_f / stat[:games]
    end
  end
end
