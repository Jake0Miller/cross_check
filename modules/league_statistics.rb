module LeagueStatistics
  def count_of_teams
    @teams.size
  end

  def total_goals_by_id
    @games.inject({}) do |hash, game|
      this_game = game[1]
      hash[this_game.away_team_id.to_sym] ||= 0
      hash[this_game.away_team_id.to_sym] += this_game.away_goals.to_i
      hash[this_game.home_team_id.to_sym] ||= 0
      hash[this_game.home_team_id.to_sym] = this_game.home_goals.to_i
      hash
    end
  end

  def total_games_by_id
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
      if total_goals_by_id[team[0]].nil?
        hash
      else
        hash[team[0]] = total_goals_by_id[team[0]] / total_games_by_id[team[0]].to_f
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
end
