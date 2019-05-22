class Team
  attr_reader :team_row, :team_name

  def initialize(team_row)
    @team_row = team_row
    @team_name = team_row[:teamname]
  end
end
