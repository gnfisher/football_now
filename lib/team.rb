class FootballNow::Team

  attr_accessor :name, :team_url, :league, :matches, :wins, :losses, :draws,
   :goals_for, :goals_against, :standing_in_league

   @@all = []

  def initialize(name, opt={})
    @name = name
    self.league = opt[:league] if opt[:league]
  end

  def save
    @@all << self
  end

  def league=(league)
    @league = league
    league.add_team(self)
  end

  def self.create_from_hash(team_data)
    new(team_data[:name], team_data).tap(&:save)
  end

  def self.all
    @@all
  end
end
