require './test/test_helper'

class TeamTest < Minitest::Test

  def setup
    @team_path = './data/team_info.csv'
    @rows = CSV.read(@team_path, headers: true)
    @teams = {}

    @rows.each do |row|
      @teams[row["franchiseId"]] = Team.new(row)
    end
  end

  def test_team_exists
    assert_instance_of Team, @teams['23']
  end

  def test_team_key
    assert_equal @rows.first, @teams['23'].team_row
  end
end
