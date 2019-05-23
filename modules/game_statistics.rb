module GameStatistics

  def highest_total_score
    max_goal_total = @games.max_by do |game|
      game.home_goals + game.away_goals
    end
    max_goal_total.home_goals + max_goal_total.away_goals
  end

  def lowest_total_score
    min_goal_total = @games.min_by do |game|
      game.home_goals + game.away_goals
    end
    min_goal_total.home_goals + min_goal_total.away_goals
  end

  def biggest_blowout
    max_total_difference = @games.max_by do |game|
      game.home_goals - game.away_goals
    end
    (max_total_difference.home_goals.to_i - max_total_difference.away_goals.to_i).abs
  end

  def percentage_home_wins
    home_wins = 0
    count_of_games = @games.count
    @games.each do |game|
      if game.outcome.include? "home win"
        home_wins += 1
      end
    end
    (home_wins / count_of_games.to_f) * 100
  end

  def percentage_away_wins
    away_wins = 0
    count_of_games = @games.count
    @games.each do |game|
      if game.outcome.include? "away win"
        away_wins += 1
      end
    end
    (away_wins / count_of_games.to_f) * 100
  end

  def count_of_games_by_season
    count_of_games_by_season = {}

    all_seasons = @games.group_by do |game|
      game.season
    end

    all_seasons.each do |season, games|
      count_of_games_by_season[season] = games.count
    end
    count_of_games_by_season
  end

  def average_goals_per_game
    game_score_total = []
    @games.each do |game|
      game_score_total << game.home_goals + game.away_goals
    end
    (game_score_total.sum.to_f / @games.size).round(2)
  end

  def average_goals_by_season
    average_goals_by_season = {}
    all_seasons = @games.group_by do |game|
      game.season
    end

    all_seasons.each do |season, games|
      sum_of_each_game_in_season = games.sum do |game|
        game.home_goals + game.away_goals
      end
      avg_goals = (sum_of_each_game_in_season.to_f / games.length).round(2)
      average_goals_by_season[season] =  avg_goals
    end
    average_goals_by_season
  end

end
