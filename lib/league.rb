class FootballNow::League

  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @teams = []
  end

  def save
    @@all << self
  end

  def self.new_from_hash(league_hash)
    new(league_hash[:name])
  end

  def self.all
    @@all
  end
end
