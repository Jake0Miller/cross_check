require 'pry'
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
    team_games = find_games_by_team_id(team_id)
    wins = 0
    team_games.each do |game|
      if team_id == game.home_team_id && home_won?(game)
        wins += 1
      elsif team_id == game.away_team_id && away_won?(game)
        wins += 1
      end
    end
    win_percent = (100.0*wins/team_games.length).round(2)
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
    head_to_head(our_team_id).max_by do |team,percent|
      percent
    end[0]
  end

  def rival(our_team_id)
    head_to_head(our_team_id).min_by do |team,percent|
      percent
    end[0]
  end

  def head_to_head(our_team_id)
    games = find_games_by_team_id(our_team_id)
    head_hash = {}
    @teams.each do |team|
      if team[1].team_id != our_team_id
        this_teams_games = find_games_by_team_id(team[1].team_id, games)
        this_teams_wins = percent_wins(our_team_id, this_teams_games)
        head_hash[team[1].team_name] = this_teams_wins
      end
    end
    head_hash
  end

  def worst_loss(team_id)
    games = find_games_by_team_id(team_id).map do |game|
      #take out map...
      #binding.pry
      if !won_at_home?(team_id, game) && !won_away?(team_id, game)
        #binding.pry
        (game.home_goals - game.away_goals).abs
      end
    end

    not_nil_games = games.find_all do |game|
      !game.nil?
    end

    not_nil_games.max_by do |diff|
      diff #take out this line and switch to .max
    end 
  end 

  def biggest_team_blowout(team_id)
    diff = find_games_by_team_id(team_id, games).map do |game|
        if won_at_home?(team_id,game) || won_away?(team_id,game)
            (game.home_goals - game.away_goals).abs
        end
      end
    not_nil = diff.find_all do |game|
      !game.nil?
    end
    not_nil.max_by do |biggest_diff|
      biggest_diff
    end
  end
end
