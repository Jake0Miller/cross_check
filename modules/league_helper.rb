module LeagueHelper
  def total_goals(home=true, away=true)
    @games.each_with_object(Hash.new(0)) do |game,hash|
      hash[game.away_team_id.to_sym] += game.away_goals.to_i if away
      hash[game.home_team_id.to_sym] += game.home_goals.to_i if home
    end
  end

  def total_games(home=true, away=true)
    @games.each_with_object(Hash.new(0)) do |game,hash|
      hash[game.away_team_id.to_sym] += 1 if away
      hash[game.home_team_id.to_sym] += 1 if home
    end
  end

  def average_score(home = true, away = true)
    @teams.each_with_object({}) do |team,hash|
      goals = total_goals(home, away)[team[0]]
      games = total_games(home, away)[team[0]]
      hash[team[0]] = (goals / games.to_f).round(2) if games != 0
    end
  end

  def total_goals_allowed
    @games.each_with_object(Hash.new(0)) do |game,hash|
      hash[game.away_team_id.to_sym] += game.home_goals.to_i
      hash[game.home_team_id.to_sym] += game.away_goals.to_i
    end
  end

  def average_goals_allowed
    @teams.each_with_object({}) do |team,hash|
      goals_allowed = total_goals_allowed[team[0]]
      games = total_games[team[0]].to_f
      hash[team[0]] = (goals_allowed / games).round(2)
      hash
    end
  end

  def total_wins(home = true, away = true)
    @games.each_with_object({}) do |game,hash|
      hash[game.away_team_id.to_sym] ||= 0
      hash[game.home_team_id.to_sym] ||= 0
      if game.away_goals > game.home_goals && away
        hash[game.away_team_id.to_sym] += 1
      elsif game.away_goals < game.home_goals && home
        hash[game.home_team_id.to_sym] += 1
      end
    end
  end

  def win_percentage(home = true, away = true)
    total_wins(home,away).map do |k,v|
      [k,v *= (1.0/total_games(home,away)[k]).round(2)]
    end.to_h
  end

  def home_away_win_percent_diff
    home_percent = win_percentage(true,false)
    away_percent = win_percentage(false,true)
    home_percent.each_with_object({}) do |item,hash|
      hash[item[0]] = (home_percent[item[0]] - away_percent[item[0]]).round(2)
    end
  end
end
