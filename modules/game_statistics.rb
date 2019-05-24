module GameStatistics
  def highest_total_score
    max_goal_total = @games.max do |a,b|
      a.home_goals + a.away_goals <=> b.home_goals + b.away_goals
    end
    max_goal_total.home_goals + max_goal_total.away_goals
  end

  def lowest_total_score
    min_goal_total = @games.min do |a,b|
      a.home_goals + a.away_goals <=> b.home_goals + b.away_goals
    end
    min_goal_total.home_goals + min_goal_total.away_goals
  end

  def biggest_blowout
    max_total_diff = @games.max do |a,b|
      (a.home_goals - a.away_goals).abs <=> (b.home_goals - b.away_goals).abs
    end
    (max_total_diff.home_goals - max_total_diff.away_goals).abs
  end

  def percentage_home_wins
    home_wins = @games.count do |game|
      game.home_goals > game.away_goals
    end
    (100.0 * home_wins / @games.length).round(2)
  end

  def percentage_away_wins
    away_wins = @games.count do |game|
      game.home_goals < game.away_goals
    end
    (100.0 * away_wins / @games.length).round(2)
  end

  def count_of_games_by_season
    @games.group_by do |game|
      game.season
    end.transform_values do |games|
      games.length
    end
  end

  def average_goals_per_game(games = @games)
    game_score_total = games.sum do |game|
      game.home_goals + game.away_goals
    end
    (game_score_total.to_f / games.length).round(2)
  end

  def average_goals_by_season
    @games.group_by do |game|
      game.season
    end.transform_values do |games|
      average_goals_per_game(games)
    end
  end
end
