class FootballNow::Team

  attr_accessor :name, :league, :wins, :losses, :draws, :goals_for,
  :goals_against, :points, :standing
  attr_reader :matches

   @@all = []

  def initialize(name, opt={})
    @name = name
    @matches = []
    opt.each {|method, arg| send("#{method}=", arg) if self.respond_to?("#{method}=")}
  end

  def save
    @@all << self
    self
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
    team = new(team_data[:name], team_data).tap(&:save)
  end

  def self.all
    @@all
  end

  def self.reset
    @@all.clear
  end
end
