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

  def get_game_by_season_and_game_id(season_id, game_id)
    @game_teams.find_all do |game|
      game.game_id == game_id
    end
  end
end
