module LeagueHelper
  def total_goals(home=true, away=true)
    @games.inject(Hash.new(0)) do |hash, game|
      hash[game.away_team_id.to_sym] += game.away_goals.to_i if away
      hash[game.home_team_id.to_sym] += game.home_goals.to_i if home
      hash
    end
  end

  def total_games(home=true, away=true)
    @games.inject(Hash.new(0)) do |hash, game|
      hash[game.away_team_id.to_sym] += 1 if away
      hash[game.home_team_id.to_sym] += 1 if home
      hash
    end
  end

  def average_score(home = true, away = true)
    @teams.inject({}) do |hash, team|
      goals = total_goals(home, away)[team[0]]
      games = total_games(home, away)[team[0]]
      hash[team[0]] = (goals / games.to_f).round(2) if games != 0
      hash
    end
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
      goals_allowed = total_goals_allowed[team[0]]
      games = total_games[team[0]].to_f
      hash[team[0]] = (goals_allowed / games).round(2)
      hash
    end
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
end
