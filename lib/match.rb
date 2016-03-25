class FootballNow::Match

  attr_accessor :round, :date, :home_score, :away_score

  attr_reader :home_team, :away_team

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

  def league
    @home_team.league
  end

  def self.create_from_hash(match_hash)
    home            = match_hash.delete(:home_team)
    away            = match_hash.delete(:away_team)
    match           = new(match_hash).tap(&:save)
    match.home_team = FootballNow::Team.find_by_name(home)
    match.away_team = FootballNow::Team.find_by_name(away)
    match
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.get_recent_results(league)
    round_number = most_recent_round_number(league)
    league.matches.select {|match| match.round == round_number}
  end

  def self.most_recent_round_number(league)
    league.matches.max {|a,b| a.round <=> b.round}.round
  end
end
