module SeasonStatistics
  def biggest_bust(season_id)
    reg_wins = reg_wins_by_team(season_id)

    post_wins = post_wins_by_team(season_id)

    reg_wins = post_reg_difference(reg_wins, post_wins)

    most_improved = reg_wins.min_by do |win|
      win[1]
    end
    @teams[most_improved[0].to_sym].team_name
  end

  def biggest_surprise(season_id)
    reg_wins = reg_wins_by_team(season_id)

    post_wins = post_wins_by_team(season_id)

    reg_wins = post_reg_difference(reg_wins, post_wins)

    most_improved = reg_wins.max_by do |win|
      win[1]
    end
    @teams[most_improved[0].to_sym].team_name
  end

  def winningest_coach(season_id)
    game_teams_by_season = all_games_by_season(season_id).map do |game|
      get_game_by_season_and_game_id(season_id, game.game_id)
    end.flatten
    coach_wins = Hash.new(0)
    game_teams_by_season.each do |game|
      if game.head_coach && game.won == "TRUE"
        coach_wins[game.head_coach] += 1
      end
    end
    coach_wins.max_by do |coach, wins|
       wins
    end.first
  end

  def worst_coach(season_id)
    game_teams_by_season = all_games_by_season(season_id).map do |game|
      get_game_by_season_and_game_id(season_id, game.game_id)
    end.flatten
    coach_wins = Hash.new(0)
    game_teams_by_season.each do |game|

      if game.head_coach && game.won == "TRUE"
        coach_wins[game.head_coach] += 1
      end
    end
    coach_wins.min_by do |coach, wins|
       wins
    end.first
  end
end
