module GameStatistics
  def highest_total_score
    max_goal_total = games.max do |a,b|
      a[1].home_goals + a[1].away_goals <=> b[1].home_goals + b[1].away_goals
    end
    max_goal_total[1].home_goals + max_goal_total[1].away_goals
  end

  def lowest_total_score
    min_goal_total = games.min do |a,b|
      a[1].home_goals + a[1].away_goals <=> b[1].home_goals + b[1].away_goals
    end
    min_goal_total[1].home_goals + min_goal_total[1].away_goals
  end

  def biggest_blowout
    max_diff = games.max do |a,b|
      (a[1].home_goals - a[1].away_goals).abs <=> (b[1].home_goals - b[1].away_goals).abs
    end
    (max_diff[1].home_goals - max_diff[1].away_goals).abs
  end

  def percentage_home_wins
    home_wins = games.count do |game|
      game[1].home_goals > game[1].away_goals
    end
    (home_wins.to_f / games.length).round(2)
  end

  def percentage_visitor_wins
    away_wins = games.count do |game|
      game[1].home_goals < game[1].away_goals
    end
    (away_wins.to_f / games.length).round(2)
  end

  def count_of_games_by_season
    games.group_by do |game|
      game[1].season
    end.transform_values do |games|
      games.length
    end
  end

  def average_goals_per_game(our_games = games)
    game_score_total = our_games.sum do |game|
      game[1].home_goals + game[1].away_goals
    end
    (game_score_total.to_f / our_games.length).round(2)
  end

  def average_goals_by_season
    games.group_by do |game|
      game[1].season
    end.transform_values do |games|
      average_goals_per_game(games)
    end
  end
end
