class FootballNow::Team

  attr_accessor :name, :team_url, :league, :matches, :wins, :losses, :draws,
   :goals_for, :goals_against, :standing_in_league

   @@all = []

  def initialize(name, opt={})
    @name = name
    @league = opt[:league] if opt[:league]
    @team_url = opt[:team_url] if opt[:team_url]
  end

  def save
    @@all << self
  end

  def league=(league)
    @league = league
    league.add_team(self)
  end

  def self.all
    @@all
  end
end
