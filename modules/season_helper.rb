module SeasonHelper

  def all_games_by_season(season_id)
    @games.find_all do |game|
      game.season == season_id
    end
  end

  def season_games_by_type(season_id)
    all_games_by_season(season_id).group_by do |game|
      game.type
    end
  end

  def reg_season_game_teams(season_id)
    @game_teams.find_all do |game_team|
      season_games_by_type(season_id)['R'].any? do |game|
        game.game_id == game_team.game_id
      end
    end
  end

  def post_season_game_teams(season_id)
    @game_teams.find_all do |game_team|
      season_games_by_type(season_id)['P'].any? do |game|
        game.game_id == game_team.game_id
      end
    end
  end

  def reg_season_by_team(season_id)
    reg_season_game_teams(season_id).group_by do |game_team|
      game_team.team_id
    end
  end

  def post_season_by_team(season_id)
    post_season_game_teams(season_id).group_by do |game_team|
      game_team.team_id
    end
  end

  def reg_wins_by_team(season_id)
    reg_wins = {}
    reg_season_by_team(season_id).each do |game_team|
      wins = game_team[1].count do |game|
        game.won == "TRUE"
      end
      reg_wins[game_team[0]] = (wins / game_team[1].length.to_f).round(2)
    end
    reg_wins
  end

  def post_wins_by_team(season_id)
    post_wins = {}
    post_season_by_team(season_id).each do |game_team|
      wins = game_team[1].count do |game|
        game.won == "TRUE"
      end
      post_wins[game_team[0]] = (wins / game_team[1].length.to_f).round(2)
    end
    post_wins
  end

  def post_reg_difference(reg_wins, post_wins)
    reg_wins.each do |team, percent|
      reg_wins[team] = post_wins[team] - reg_wins[team]
    end
    reg_wins
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

  def game_teams_by_season(season_id)
    all_games_by_season(season_id).map do |game|
      get_game_by_season_and_game_id(season_id, game.game_id)
    end.flatten
  end

  def coach_wins(season_id)
    coach_wins = Hash.new(0)
    coach_game_count = Hash.new(0)

    game_teams_by_season(season_id).each do |game|
      coach_game_count[game.head_coach] += 1

      if game.won == "TRUE"
        coach_wins[game.head_coach] += 1
      end
    end
    [coach_wins, coach_game_count]
  end

  def coach_win_percentage(season_id)
    coach_wins, coach_game_count = coach_wins(season_id)
    coach_win_percentages = Hash.new(0)

    coach_wins.each do |coach, wins|
      coach_win_percentages[coach] = (wins.to_f / coach_game_count[coach])
    end
    coach_win_percentages
  end
end
