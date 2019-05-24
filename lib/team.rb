require 'pry'
class Team
  attr_reader :team_row, :team_name, :team_id

  def initialize(team_row)
    @team_row = team_row
    @team_name = team_row[:teamname]
    @team_id = team_row[:team_id]
    # @franchise_id = team_row[:franchiseid]
    # @short_name = team_row[:shortname]
    # @abbreviation = team_row[:abbreviation]
    # @link = team_row[:link]
  end
end
#binding.pry
