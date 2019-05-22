#this module works with team_stats
module TeamInformation

  def find_team(team_id)
    @teams.find do |team|
      team.team_id == team_id
    end 
  end

end
