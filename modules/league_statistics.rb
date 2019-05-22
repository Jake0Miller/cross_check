module LeagueStatistics
  def count_of_teams
    @teams.size
  end

  def total_goals
    @games.inject({}) do |hash, game|
      hash[game[1].away_team_id.to_sym] ||= 0
      hash[game[1].away_team_id.to_sym] += game[1].away_goals.to_i
      hash[game[1].home_team_id.to_sym] ||= 0
      hash[game[1].home_team_id.to_sym] = game[1].home_goals.to_i
      hash
    end
  end

  def total_games
    @games.inject({}) do |hash, game|
      hash[game[1].away_team_id.to_sym] ||= 0
      hash[game[1].away_team_id.to_sym] += 1
      hash[game[1].home_team_id.to_sym] ||= 0
      hash[game[1].home_team_id.to_sym] = 1
      hash
    end
  end

  def average_score
    @teams.inject({}) do |hash, team|
      if total_goals[team[0]].nil?
        hash
      else
        hash[team[0]] = total_goals[team[0]] / total_games[team[0]].to_f
      end
      hash
    end
  end

  def best_offense
    @teams[average_score.max_by { |k,v| v }.first].team_name
  end

  def worst_offense
    @teams[average_score.min_by { |k,v| v }.first].team_name
  end

  def total_goals_allowed
    @games.inject({}) do |hash, game|
      hash[game[1].away_team_id.to_sym] ||= 0
      hash[game[1].away_team_id.to_sym] += game[1].home_goals.to_i
      hash[game[1].home_team_id.to_sym] ||= 0
      hash[game[1].home_team_id.to_sym] = game[1].away_goals.to_i
      hash
    end
  end

  def average_goals_allowed
    @teams.inject({}) do |hash, team|
      if total_goals[team[0]].nil?
        hash
      else
        hash[team[0]] = total_goals_allowed[team[0]] / total_games[team[0]].to_f
      end
      hash
    end
  end

  def best_defense
    @teams[average_goals_allowed.min_by { |k,v| v }.first].team_name
  end

  def worst_defense
    @teams[average_goals_allowed.max_by { |k,v| v }.first].team_name
  end

  def total_goals_away
    @games.inject({}) do |hash, game|
      hash[game[1].away_team_id.to_sym] ||= 0
      hash[game[1].away_team_id.to_sym] += game[1].away_goals.to_i
      hash
    end
  end

  def total_goals_home
    @games.inject({}) do |hash, game|
      hash[game[1].home_team_id.to_sym] ||= 0
      hash[game[1].home_team_id.to_sym] = game[1].home_goals.to_i
      hash
    end
  end

  def total_away_games
    @games.inject({}) do |hash, game|
      hash[game.away_team_id.to_sym] ||= 0
      hash[game.away_team_id.to_sym] += 1
      hash
    end
  end

  def total_home_games
    @games.inject({}) do |hash, game|
      hash[game.home_team_id.to_sym] ||= 0
      hash[game.home_team_id.to_sym] = 1
      hash
    end
  end

  def average_score_away
    @teams.inject({}) do |hash, team|
      if total_goals[team[0]].nil?
        hash
      else
        hash[team[0]] = total_goals_away[team[0]] / total_games[team[0]].to_f
      end
      hash
    end
  end

  def average_score_home
    @teams.inject({}) do |hash, team|
      if total_goals[team[0]].nil?
        hash
      else
        hash[team[0]] = total_goals_home[team[0]] / total_games[team[0]].to_f
      end
      hash
    end
  end

  def highest_scoring_visitor
    @teams[average_score_away.max_by { |k,v| v }.first].team_name
  end

  def lowest_scoring_visitor
    @teams[average_score_away.min_by { |k,v| v }.first].team_name
  end

  def highest_scoring_home_team
    @teams[average_score_home.max_by { |k,v| v }.first].team_name
  end

  def lowest_scoring_home_team
    @teams[average_score_home.min_by { |k,v| v }.first].team_name
  end

  def total_wins
    @games.inject({}) do |hash, game|
      if game[1].away_goals > game[1].home_goals
        hash[game[1].away_team_id.to_sym] ||= 0
        hash[game[1].away_team_id.to_sym] += 1
      elsif game[1].away_goals < game[1].home_goals
        hash[game[1].home_team_id.to_sym] ||= 0
        hash[game[1].home_team_id.to_sym] = 1
      end
      hash
    end
  end

  def winningest_team
    @teams[total_wins.max_by { |k,v| v }.first].team_name
  end
end
