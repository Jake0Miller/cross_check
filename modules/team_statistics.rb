require 'pry'
module TeamStatistics
  def team_info(team_id)
    keys = ["team_id", "franchise_id", "short_name", "team_name", "abbreviation", "link"]
    values = @teams[team_id.to_sym].team_row.to_h.values
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
      our_score(team_id, game[1])
    end
    our_score(team_id, highest_score[1])
  end

  def fewest_goals_scored(team_id)
    lowest_score = find_games_by_team_id(team_id).min_by do |game|
      our_score(team_id, game[1])
    end
    our_score(team_id, lowest_score[1])
  end

  def favorite_opponent(our_team_id)
    head_to_head(our_team_id).max_by do |team,percent|
      percent
    end[0]
  end

  def rival(our_team_id)
    head_to_head(our_team_id).min_by do |team,percent|
      percent
    end[0]
  end

  def biggest_team_blowout(team_id)
    find_all_wins(team_id).max do |diff_a,diff_b|
      diff_a <=> diff_b
    end
  end

  def worst_loss(team_id)
    find_all_losses(team_id).max do |diff_a,diff_b|
      diff_a <=> diff_b
    end
  end

  def head_to_head(our_team_id)
    win_percent_by_team_hash(our_team_id, find_games_by_team_id(our_team_id))
  end

  def seasonal_summary(team_id)
    games = find_games_by_team_id(team_id).group_by {|game| game[1].season}
    games.each_with_object(Hash.new) do |season,hash|
      hash[season[0]] = {}
      hash[season[0]][:regular_season] = summary(team_id,season[1],'R')
      hash[season[0]][:postseason] = summary(team_id,season[1],'P')
    end
  end
end
