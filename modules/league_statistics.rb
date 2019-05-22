module LeagueStatistics
  def count_of_teams
    @teams.size
  end

  def total_goals
    @games.inject({}) do |hash, game|
      this_game = game[1]
      hash[this_game.away_team_id.to_sym] ||= 0
      hash[this_game.away_team_id.to_sym] += this_game.away_goals.to_i
      hash[this_game.home_team_id.to_sym] ||= 0
      hash[this_game.home_team_id.to_sym] = this_game.home_goals.to_i
      hash
    end
  end

  def total_games
    @games.inject({}) do |hash, game|
      this_game = game[1]
      hash[this_game.away_team_id.to_sym] ||= 0
      hash[this_game.away_team_id.to_sym] += 1
      hash[this_game.home_team_id.to_sym] ||= 0
      hash[this_game.home_team_id.to_sym] = 1
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
      hash[this_game[1].away_team_id.to_sym] ||= 0
      hash[this_game[1].away_team_id.to_sym] += this_game[1].home_goals.to_i
      hash[this_game[1].home_team_id.to_sym] ||= 0
      hash[this_game[1].home_team_id.to_sym] = this_game[1].away_goals.to_i
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
end
