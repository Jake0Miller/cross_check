module GameStatistics
# use .abs to get a positive number for blowout
  def highest_total_score
    max_goal_total = @games.max_by do |game|
      game.home_goals + game.away_goals
    end
    max_goal_total.home_goals.to_i + max_goal_total.away_goals.to_i
  end

  def lowest_total_score
    min_goal_total = @games.min_by do |game|
      game.home_goals + game.away_goals
    end
    min_goal_total.home_goals.to_i + min_goal_total.away_goals.to_i
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


end
