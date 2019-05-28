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
    reg_wins.merge(post_wins) do |team, reg, post|
      post - reg
    end
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

  def get_game_by_season_and_game_id(season_id, game_id)
    @game_teams.find_all do |game|
      game.game_id == game_id
    end
  end

  # def game_teams_by_season(season_id)
  #   all_games_by_season(season_id).map do |game|
  #     get_game_by_season_and_game_id(season_id, game.game_id)
  #   end.flatten
  # end

  def coach_wins(season_id)
    coach_wins = Hash.new(0)
    coach_game_count = Hash.new(0)
    game_teams_by_season(season_id).each do |game|
      coach_game_count[game.head_coach] += 1
      coach_wins[game.head_coach] += 1 if game.won == "TRUE"
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
