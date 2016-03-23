class FootballNow::Team

  attr_accessor :name, :team_url, :league, :matches, :wins, :losses, :draws,
   :goals_for, :goals_against, :standing_in_league

   @@all = []

  def initialize(name, league = nil, team_url = nil)
    @name = name
    @league = league if league
    @team_url = team_url if team_url
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
