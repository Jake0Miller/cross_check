require './test/test_helper'
#require './modules/team_statistics'
#require './modules/team_information'

class TeamTest < Minitest::Test
  #include TeamInformation
  #include TeamStatistics
  def setup

    @game_path = './data/game_dummy.csv'
    @team_path = './data/team_dummy.csv'
    @game_teams_path = './data/game_teams_stats_dummy.csv'
    @locations = { games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path }
    @stat_tracker = StatTracker.from_csv(@locations)

    @rows = CSV.read(@team_path, headers: true, header_converters: CSV::HeaderConverters[:symbol])
    @teams = {}

    @rows.each do |row|
      @teams[row[:team_id].to_sym] = Team.new(row)
    end
  end

  def test_team_exists
    assert_instance_of Team, @teams['1'.to_sym]
  end

  def test_team_key
    assert_equal @rows.first, @teams['1'.to_sym].team_row
  end

  def test_team_attributes #tests stattracker
    assert_equal "Devils", @teams["1".to_sym].team_name
    assert_equal "1", @teams["1".to_sym].team_id
  end
end
