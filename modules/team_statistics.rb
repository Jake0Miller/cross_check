module TeamStatistics

  def team_info(team_id)
    keys = ["team_id", "franchiseId", "shortName", "teamName", "abbreviation", "link"]
    values = @teams[team_id].team_row.to_h.values
    keys.zip(values).to_h
  end

  def best_season(team_id)
    win_percent_by_season(team_id).max_by { |season, avg| avg }.first
  end

  def worst_season(team_id)
    win_percent_by_season(team_id).min_by { |season, avg| avg }.first
  end

  def average_win_percentage(team_id)
    percent_wins(team_id,find_games_by_team_id(team_id))
  end

  def most_goals_scored(team_id)
    highest_score = find_games_by_team_id(team_id).max_by do |game|
      extreme_scores(team_id, game)
    end
    extreme_scores(team_id, highest_score)
  end

  def fewest_goals_scored(team_id)
    lowest_score = find_games_by_team_id(team_id).min_by do |game|
      extreme_scores(team_id, game)
    end
    extreme_scores(team_id, lowest_score)
  end

  def favorite_opponent(our_team_id)
    games = find_games_by_team_id(our_team_id)
    lowest_percent_wins = 100
    fav_opponent = nil
    @teams.each do |team|
      if team[1].team_id != our_team_id
        this_teams_wins = percent_wins(team[1].team_id, games)
        if this_teams_wins < lowest_percent_wins
          lowest_percent_wins = this_teams_wins
          fav_opponent = team[1]
        end
      end
    end
    fav_opponent.team_name
  end

  def rival(our_team_id)
    games = find_games_by_team_id(our_team_id)
    highest_percent_wins = 0
    rival_team = nil
    @teams.each do |team|
      if team[1].team_id != our_team_id
        this_teams_wins = percent_wins(team[1].team_id, games)
        if this_teams_wins > highest_percent_wins
          highest_percent_wins = this_teams_wins
          rival_team = team[1]
        end
      end
    end
    rival_team.team_name
  end
end
