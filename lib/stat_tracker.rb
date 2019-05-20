class StatTracker
  attr_reader :locations

  def initialize(games, teams, stats)
    @games = games
    @teams = teams
    @stats = stats
  end

  def self.from_csv(locations)
    
    StatTracker.new(games, teams, stats)
  end
end
