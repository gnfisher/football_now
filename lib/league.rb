class FootballNow::League

  attr_accessor :name, :league_url, :teams

  @@all = []

  def initialize(name, league_url)
    @name = name
    @league_url = league_url
    @teams = []
  end

  def save
    @@all << self
    self
  end

  def add_team(team)
    team.league ||= self
    @teams << team unless @teams.include? team
  end

  def matches
    @teams.map { |team| team.matches }.flatten.uniq
  end

  def self.find_by_name(name)
    self.all.detect {|league| league.name.downcase == name.downcase}
  end

  def self.new_from_hash(league_hash)
    new(league_hash[:name], league_hash[:league_url])
  end

  def self.create_from_hash(league_hash)
    new_from_hash(league_hash).tap(&:save)
  end

  def self.all
    @@all
  end

  def self.print_leagues
    self.all.each.with_index(1) {|league, index| puts "#{index}. #{league.name}"}
  end

  def self.get_league_by_index(index)
    self.all[index]
  end

  def self.reset
    @@all.clear
  end
end
