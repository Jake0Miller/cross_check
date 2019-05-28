module SeasonStatistics
  def biggest_bust(season_id)
    most_improved = post_reg_difference(season_id).min do |win_a, win_b|
      win_a[1] <=> win_b[1]
    end
    @teams[most_improved[0].to_sym].team_name
  end

  # check if there are teams in the pre that don't make post
  def biggest_surprise(season_id)
    most_improved = post_reg_difference(season_id).max do |win_a, win_b|
      win_a[1] <=> win_b[1]
    end
    @teams[most_improved[0].to_sym].team_name
  end

  def most_hits(season_id)
    team = hits_by_team(season_id).max do |hits_a, hits_b|
      hits_a[1] <=> hits_b[1]
    end
    @teams[team[0].to_sym].team_name
  end

  def fewest_hits(season_id)
    team = hits_by_team(season_id).min do |hits_a, hits_b|
      hits_a[1] <=> hits_b[1]
    end
    @teams[team[0].to_sym].team_name
  end

  def power_play_goal_percentage(season_id)
    game_teams = game_teams_by_season(season_id)
    power_goals = game_teams.sum {|game_team| game_team.power_play_goals}
    power_opps = game_teams.sum {|game_team| game_team.power_play_opportunities}
    (power_goals.to_f / power_opps).round(2)
  end

  def winningest_coach(season_id)
    coach_wins = get_coach_win_count(season_id)
    coach_wins.max_by do |coach, wins|
       wins
    end.first
  end

  def worst_coach(season_id)
    coach_wins = get_coach_win_count(season_id)
    coach_wins.min_by do |coach, wins|
       wins
    end.first
  end
end
