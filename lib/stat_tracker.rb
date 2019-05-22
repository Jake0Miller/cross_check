require 'csv'

class StatTracker
  #include TeamStats
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
    CSV

  end

  def self.get_teams(teams_path) #team instance
    teams = {}
    CSV.foreach('data/team_info.csv', headers: true, header_converters: CSV::HeaderConverters[:symbol]) do |row|
      teams[row[0]] = Team.new(row)
    end
    teams
  end

  def self.get_games(games_path)
    # get the games from games_path (the csv)
    # put games into hash with id as key and game row object as value
    games = {}

    CSV.foreach(games_path, headers: true) do |row|
      games[row.first] = Game.new(row)
    end
    games
  end
end
