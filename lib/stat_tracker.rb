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

  def self.get_game_teams(path)
    game_teams = {}
    CSV.foreach(path, headers: true) do |row|
      game_teams["#{row[0]}-#{row[1]}".to_sym] = GameTeam.new(row)
    end
    game_teams
  end
end
