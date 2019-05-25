module LeagueStatistics
  def count_of_teams
    @teams.length
  end

  def best_offense
    @teams[average_score.max_by { |k,v| v }.first].team_name
  end

  def worst_offense
    @teams[average_score.min_by { |k,v| v }.first].team_name
  end

  def best_defense
    @teams[average_goals_allowed.min_by { |k,v| v }.first].team_name
  end

  def worst_defense
    @teams[average_goals_allowed.max_by { |k,v| v }.first].team_name
  end

  def highest_scoring_visitor
    @teams[average_score(false, true).max_by { |k,v| v }.first].team_name
  end

  def lowest_scoring_visitor
    @teams[average_score(false, true).min_by { |k,v| v }.first].team_name
  end

  def highest_scoring_home_team
    @teams[average_score(true, false).max_by { |k,v| v }.first].team_name
  end

  def lowest_scoring_home_team
    @teams[average_score(true, false).min_by { |k,v| v }.first].team_name
  end

  def winningest_team
    @teams[total_wins.max_by { |k,v| v }.first].team_name
  end

  def best_fans
    team = home_away_win_percent_diff.max do |a,b|
      a[1] <=> b[1]
    end
    @teams[team[0]].team_name
  end

  def worst_fans
    home_away_win_percent_diff.find_all do |team|
      team[1] < 0
    end.map {|team| @teams[team[0]].team_name}
  end
end
