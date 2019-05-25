class Team
  attr_reader :team_row, :team_name, :team_id

  def initialize(team_row)
    @team_row = team_row
    @team_name = team_row[:teamname]
    @team_id = team_row[:team_id]
  end
end
