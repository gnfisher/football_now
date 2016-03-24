class FootballNow::Match

  # Should attribuets be mandatory? Validation?

  # Will need a find_team_by_name function to save team...

  attr_accessor :round, :date, :home_team, :away_team,
                :home_score, :away_score

  @@all = []

  def initialize(opt = {})
    opt.each {|method, arg| send("#{method}=", arg) if respond_to?("#{method}=") }
  end

  def home_team=(team)
    @home_team = team
    team.add_match(self, 'home_team')
  end

  def away_team=(team)
    @away_team = team
    team.add_match(self, 'away_team')
  end

  def self.create_from_hash(match_hash)
    new(match_hash).tap(&:save)
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end
end
