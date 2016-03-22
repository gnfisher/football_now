class FootballNow::League

  attr_accessor :name, :league_url

  @@all = []

  def initialize(name, league_url)
    @name = name
    @league_url = league_url
    @teams = []
  end

  def save
    @@all << self
  end

  def self.new_from_hash(league_hash)
    new(league_hash[:name], league_hash[:league_url])
  end

  def self.create_from_hash(league_hash)
    new(league_hash[:name], league_hash[:league_url]).tap(&:save)
  end

  def self.all
    @@all
  end
end
