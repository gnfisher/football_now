class FootballNow::Team

  attr_accessor :name, :league, :wins, :losses, :draws, :goals_for,
  :goals_against, :points, :standing
  attr_reader :matches

   @@all = []

  def initialize(name, opt={})
    @name = name
    self.league = opt[:league] if opt[:league]
    @matches = []
  end

  def save
    @@all << self
  end

  def league=(league)
    @league = league
    league.add_team(self)
  end

  def add_match(match, key)
    match.send("#{key}=", self) unless match.send(key)
    @matches << match
  end

  def self.find_by_name(team_name)
    @@all.detect {|team| team.name.downcase == team_name.downcase}
  end

  def self.create_from_hash(team_data)
    lg = team_data.delete(:league)
    team = new(team_data[:name], team_data).tap(&:save)
    team.league = FootballNow::League.find_by_name(lg)
    team
  end

  def self.all
    @@all
  end

  def self.reset
    @@all.clear
  end
end
