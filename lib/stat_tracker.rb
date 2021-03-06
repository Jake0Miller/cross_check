require 'csv'
require_relative '../lib/team'
require_relative '../lib/game'
require_relative '../lib/game_team'
require_relative '../modules/game_statistics'
require_relative '../modules/league_statistics'
require_relative '../modules/league_helper'
require_relative '../modules/team_statistics'
require_relative '../modules/team_information'
require_relative '../modules/season_stats'
require_relative '../modules/season_helper'

class StatTracker
  include GameStatistics
  include TeamStatistics
  include TeamInformation
  include LeagueStatistics
  include LeagueHelper
  include SeasonStatistics
  include SeasonHelper

  attr_reader :games, :teams, :game_teams, :all_games_by_season

  def initialize(games, teams, game_teams, all_games_by_season)
    @games = games
    @teams = teams
    @game_teams = game_teams
    @all_games_by_season = all_games_by_season
  end

  def self.from_csv(locations)
    games = get_games(locations[:games])
    teams = get_teams(locations[:teams])
    game_teams = get_game_teams(locations[:game_teams])
    all_games_by_season = get_all_games_by_season(games)
    StatTracker.new(games, teams, game_teams, all_games_by_season)
  end

  def self.get_game_teams(path)
    game_teams = {}
    CSV.foreach(path, headers: true, header_converters: CSV::HeaderConverters[:symbol]) do |row|
      game_teams[row[0].to_sym] ||= {}
      game_teams[row[0].to_sym][row[1]] = GameTeam.new(row)
    end
    game_teams
  end

  def self.get_teams(path)
    teams = {}
    CSV.foreach(path, headers: true, header_converters: CSV::HeaderConverters[:symbol]) do |row|
      teams[row[0].to_sym] = Team.new(row)
    end
    teams
  end

  def self.get_games(path)
    games = {}
    CSV.foreach(path, headers: true, header_converters: CSV::HeaderConverters[:symbol]) do |row|
      games[row[0].to_sym] = Game.new(row)
    end
    games
  end

  def self.get_all_games_by_season(games)
    games.group_by do |game|
      game[1].season
    end
  end
end
