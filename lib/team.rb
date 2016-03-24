class FootballNow::Team

  attr_accessor :name, :league, :wins, :losses, :draws,
   :goals_for, :goals_against, :standing
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

  # Question: home_team, away_team.. how do we assign relationship here...

  def add_match(match, key)
    match.send("#{key}=", self) unless match.send(key)
    @matches << match
  end

  def self.create_from_hash(team_data)
    new(team_data[:name], team_data).tap(&:save)
  end

  def self.all
    @@all
  end
end
