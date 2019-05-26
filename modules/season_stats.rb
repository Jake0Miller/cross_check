module SeasonStatistics
  def biggest_bust(season_id)
    season_games = @games.find_all do |game|
      game.season == season_id
    end

    season_games_by_type = season_games.group_by do |game|
      game.type
    end

    reg_season_game_teams = @game_teams.find_all do |game_team|
      season_games_by_type['R'].any? do |game|
        game.game_id == game_team.game_id
      end
    end
    post_season_game_teams = @game_teams.find_all do |game_team|
      season_games_by_type['P'].any? do |game|
        game.game_id == game_team.game_id
      end
    end

    reg_season_by_team = reg_season_game_teams.group_by do |game_team|
      game_team.team_id
    end

    post_season_by_team = post_season_game_teams.group_by do |game_team|
      game_team.team_id
    end

    reg_wins_by_team = {}
    reg_season_by_team.each do |game_team|
      wins = game_team[1].count do |game|
        game.won == "TRUE"
      end
      reg_wins_by_team[game_team[0]] = (wins / game_team[1].length.to_f).round(2)
    end

    post_wins_by_team = {}
    post_season_by_team.each do |game_team|
      wins = game_team[1].count do |game|
        game.won == "TRUE"
      end
      post_wins_by_team[game_team[0]] = (wins / game_team[1].length.to_f).round(2)
    end

    reg_wins_by_team.each do |team, percent|
      reg_wins_by_team[team] = post_wins_by_team[team] - reg_wins_by_team[team]
    end
    most_improved = reg_wins_by_team.min_by do |win|
      win[1]
    end
    @teams[most_improved[0].to_sym].team_name
  end

  def biggest_surprise(season_id)
    season_games = @games.find_all do |game|
      game.season == season_id
    end

    season_games_by_type = season_games.group_by do |game|
      game.type
    end

    reg_season_game_teams = @game_teams.find_all do |game_team|
      season_games_by_type['R'].any? do |game|
        game.game_id == game_team.game_id
      end
    end
    post_season_game_teams = @game_teams.find_all do |game_team|
      season_games_by_type['P'].any? do |game|
        game.game_id == game_team.game_id
      end
    end

    reg_season_by_team = reg_season_game_teams.group_by do |game_team|
      game_team.team_id
    end

    post_season_by_team = post_season_game_teams.group_by do |game_team|
      game_team.team_id
    end

    reg_wins_by_team = {}
    reg_season_by_team.each do |game_team|
      wins = game_team[1].count do |game|
        game.won == "TRUE"
      end
      reg_wins_by_team[game_team[0]] = (wins / game_team[1].length.to_f).round(2)
    end

    post_wins_by_team = {}
    post_season_by_team.each do |game_team|
      wins = game_team[1].count do |game|
        game.won == "TRUE"
      end
      post_wins_by_team[game_team[0]] = (wins / game_team[1].length.to_f).round(2)
    end

    reg_wins_by_team.each do |team, percent|
      reg_wins_by_team[team] = post_wins_by_team[team] - reg_wins_by_team[team]
    end
    most_improved = reg_wins_by_team.max_by do |win|
      win[1]
    end
    @teams[most_improved[0].to_sym].team_name
  end
end
