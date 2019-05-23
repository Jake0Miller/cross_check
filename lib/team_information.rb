#this module works with team_stats
module TeamInformation

  def find_team(team_id)
    @teams.find do |team|
      team.team_id == team_id
    end
  end

  def get_team_name_from_id(team_id)
    @teams.find do |team|
      team.shortName == team_id
    end
  end

  def find_games_by_team_id(team_id, games = @games)
    games.find do |game|
      game.away_team_id == team_id || game.home_team_id == team_id
    end 
  end
