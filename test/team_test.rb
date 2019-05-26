require './test/test_helper'

class TeamTest < Minitest::Test
  def setup
    @rows = CSV.read('./data/team_dummy.csv',
      headers: true, header_converters: CSV::HeaderConverters[:symbol])
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

  def test_team_attributes
    assert_equal "Devils", @teams["1".to_sym].team_name
    assert_equal "1", @teams["1".to_sym].team_id
  end
end
