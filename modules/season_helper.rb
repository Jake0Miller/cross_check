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

  def game_shots
    @game_teams.map do |game_team|
      game_team.game_info[:shots]
    end
  end

  def game_goals
    @game_teams.map do |game_team|
      game_team.game_info[:goals]
    end
  end

  def season_games(season_id)
    all_games_by_season(season_id).group_by do |game|
      game.season
    end
  end

  def accurate_team(games)
    team_data = Hash.new
    games.each do |game|
      away_team = game.away_team_id
      home_team = game.home_team_id

      away_team_game = @game_teams.find do |game_team|
        game.game_id == game_team.game_id && away_team == game_team.team_id
      end
      home_team_game = @game_teams.find do |game_team|
        game.game_id == game_team.game_id && home_team == game_team.team_id
      end
      team_data[home_team] ||= {shots: 0, goals: 0}
      team_data[away_team] ||= {shots: 0, goals: 0}
      team_data[home_team][:shots] += home_team_game.shots.to_i
      team_data[home_team][:goals] += home_team_game.goals.to_i
      team_data[away_team][:shots] += away_team_game.shots.to_i
      team_data[away_team][:goals] += away_team_game.goals.to_i
    end
    team_data
  end
  
  def get_game_by_season_and_game_id(season_id, game_id)
    @game_teams.find_all do |game|
      game.game_id == game_id
    end
  end

  def coach_info(season_id)
    coach_wins = Hash.new(0)
    coach_games = Hash.new(0)
    game_teams_by_season(season_id).each do |game|
      coach_games[game.head_coach] += 1
      coach_wins[game.head_coach] += 1 if game.won == "TRUE"
    end
    [coach_wins, coach_games]
  end

  def coach_win_percentage(season_id)
    coach_wins, coach_games = coach_info(season_id)
    test = coach_games.each_with_object({}) do |coach_game, hash|
      hash[coach_game[0]] = (coach_wins[coach_game[0]].to_f / coach_game[1])
    end
  end
end
