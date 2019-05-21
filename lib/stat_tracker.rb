require 'csv'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = get_games(locations[:games])
    teams = get_teams(locations[:teams])
    game_teams = get_game_teams(locations[:game_teams])
    StatTracker.new(games, teams, game_teams)
  end

  def self.get_teams(teams_path) #team instance
    teams = {}
    CSV.foreach('data/team_info.csv', headers: true) do |row|
      teams[row[0]] = Team.new(row)
    end
    teams
  end
end
