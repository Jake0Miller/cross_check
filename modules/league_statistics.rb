module LeagueStatistics
  def count_of_teams
    @teams.size
  end

  def total_goals(home=true, away=true)
    @games.inject(Hash.new(0)) do |hash, game|
      if away
        hash[game.away_team_id.to_sym] += game.away_goals.to_i
      end
      if home
        hash[game.home_team_id.to_sym] += game.home_goals.to_i
      end
      hash
    end
  end

  def total_games(home=true, away=true)
    @games.inject(Hash.new(0)) do |hash, game|
      if away
        hash[game.away_team_id.to_sym] += 1
      end
      if home
        hash[game.home_team_id.to_sym] += 1
      end
      hash
    end
  end

  def average_score(home = true, away = true)
    @teams.inject({}) do |hash, team|
      goals = total_goals(home, away)[team[0]]
      games = total_games(home, away)[team[0]]
      if games != 0
        hash[team[0]] = (goals / games.to_f).round(2)
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
    @games.inject(Hash.new(0)) do |hash, game|
      hash[game.away_team_id.to_sym] += game.home_goals.to_i
      hash[game.home_team_id.to_sym] += game.away_goals.to_i
      hash
    end
  end

  def average_goals_allowed
    @teams.inject({}) do |hash, team|
      if total_goals[team[0]].nil?
        hash
      else
        goals_allowed = total_goals_allowed[team[0]]
        games = total_games[team[0]].to_f
        hash[team[0]] = (goals_allowed / games).round(2)
      end
      hash
    end
  end

  def best_defense
    goals_allowed = average_goals_allowed.find_all do |team|
      !team[1].nan?
    end
    @teams[goals_allowed.min_by { |k,v| v }.first].team_name
  end

  def worst_defense
    goals_allowed = average_goals_allowed.find_all do |team|
      !team[1].nan?
    end
    @teams[goals_allowed.max_by { |k,v| v }.first].team_name
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

  def total_wins(home = true, away = true)
    @games.inject({}) do |hash, game|
      hash[game.away_team_id.to_sym] ||= 0
      hash[game.home_team_id.to_sym] ||= 0
      if game.away_goals > game.home_goals && away
        hash[game.away_team_id.to_sym] += 1
      elsif game.away_goals < game.home_goals && home
        hash[game.home_team_id.to_sym] += 1
      end
      hash
    end
  end

  def winningest_team
    @teams[total_wins.max_by { |k,v| v }.first].team_name
  end

  def win_percentage(home = true, away = true)
    total_wins(home,away).map do |k,v|
      [k,v *= (100.0/total_games(home,away)[k]).round(2)]
    end.to_h
  end

  def home_away_win_percent_diff
    home_percent = win_percentage(true,false)
    away_percent = win_percentage(false,true)
    difference = {}
    home_percent.each do |k,v|
      difference[k] = (home_percent[k] - away_percent[k]).round(2)
    end
    difference
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
    end.map { |team| @teams[team[0]].team_name }
  end
end
