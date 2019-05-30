module LeagueHelper
  def total_goals_and_games(home = true, away = true)
    games.each_with_object(Hash.new) do |game,hash|
      hash[game[1].away_team_id.to_sym] ||= [0,0]
      hash[game[1].home_team_id.to_sym] ||= [0,0]
      hash[game[1].away_team_id.to_sym][0] += game[1].away_goals.to_i if away
      hash[game[1].home_team_id.to_sym][0] += game[1].home_goals.to_i if home
      hash[game[1].away_team_id.to_sym][1] += 1 if away
      hash[game[1].home_team_id.to_sym][1] += 1 if home
    end
  end

  def average_score(home = true, away = true)
    goals_and_games = total_goals_and_games(home, away)
    teams.each_with_object({}) do |team,hash|
      goals = goals_and_games[team[0]][0]
      games = goals_and_games[team[0]][1]
      hash[team[0]] = (goals / games.to_f).round(2) if games != 0
    end
  end

  def total_goals_allowed_and_games
    games.each_with_object(Hash.new) do |game,hash|
      hash[game[1].away_team_id.to_sym] ||= [0,0]
      hash[game[1].home_team_id.to_sym] ||= [0,0]
      hash[game[1].away_team_id.to_sym][0] += game[1].home_goals.to_i
      hash[game[1].home_team_id.to_sym][0] += game[1].away_goals.to_i
      hash[game[1].away_team_id.to_sym][1] += 1
      hash[game[1].home_team_id.to_sym][1] += 1
    end
  end

  def average_goals_allowed
    allowed_and_games = total_goals_allowed_and_games
    teams.each_with_object({}) do |team,hash|
      goals_allowed = allowed_and_games[team[0]][0]
      games = allowed_and_games[team[0]][1]
      hash[team[0]] = (goals_allowed.to_f / games).round(2)
    end
  end

  def total_wins_and_games
    test = games.each_with_object(Hash.new) do |game,hash|
      hash[game[1].away_team_id.to_sym] ||= {home: [0,0], away: [0,0]}
      hash[game[1].home_team_id.to_sym] ||= {home: [0,0], away: [0,0]}
      hash[game[1].home_team_id.to_sym][:home][0] += 1 if home_win?(game)
      hash[game[1].away_team_id.to_sym][:away][0] += 1 if away_win?(game)
      hash[game[1].home_team_id.to_sym][:home][1] += 1
      hash[game[1].away_team_id.to_sym][:away][1] += 1
    end
  end

  def away_win?(game)
    game[1].away_goals > game[1].home_goals
  end

  def home_win?(game)
    game[1].away_goals < game[1].home_goals
  end

  def win_percentage
    total_wins_and_games.transform_values do |games|
      wins = games[:home][0] + games[:away][0]
      games = games[:home][1] + games[:away][1]
      (wins / games.to_f).round(2)
    end
  end

  def home_away_win_percent_diff
    total_wins_and_games.transform_values do |games|
      home_percent = (games[:home][0] / games[:home][1].to_f).round(2)
      away_percent = (games[:away][0] / games[:away][1].to_f).round(2)
      home_percent - away_percent
    end
  end
end
