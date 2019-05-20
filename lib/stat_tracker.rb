class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games_path = get_games(locations[:games])
    teams_path = get_teams(locations[:teams])
    game_teams_path = get_game_teams(locations[:game_teams])
    StatTracker.new(games_path, teams_path, game_teams_path)
  end

  def self.get_games(games_path)

  end

  def self.get_teams(teams_path)

  end

  def self.get_game_teams(game_teams_path)

  end
end
