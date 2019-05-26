module SeasonStatistics
  def biggest_bust(season_id)
    reg_wins = reg_wins_by_team(season_id)

    post_wins = post_wins_by_team(season_id)

    reg_wins = post_reg_difference(reg_wins, post_wins)

    most_improved = reg_wins.min_by do |win|
      win[1]
    end
    @teams[most_improved[0].to_sym].team_name
  end

  def biggest_surprise(season_id)
    reg_wins = reg_wins_by_team(season_id)

    post_wins = post_wins_by_team(season_id)

    reg_wins = post_reg_difference(reg_wins, post_wins)

    most_improved = reg_wins.max_by do |win|
      win[1]
    end
    @teams[most_improved[0].to_sym].team_name
  end
end