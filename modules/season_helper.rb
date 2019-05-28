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

  def season_game_teams(season_id,type)
    season_games_by_type(season_id)[type].each_with_object([]) do |game,array|
      array.push(@game_teams[game.game_id.to_sym])
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
    reg_wins.merge(post_wins) do |team, reg, post|
      post - reg
    end
  end

  def game_teams_by_season(season_id)
    all_games_by_season(season_id).each_with_object([]) do |game,array|
      array.push(@game_teams[game.game_id.to_sym].values)
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
end
