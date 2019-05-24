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
end
