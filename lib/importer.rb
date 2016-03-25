class FootballNow::Importer

  def self.generate
    create_leagues
    create_teams
    binding.pry
    #create_matches
  end

  def self.create_leagues
    FootballNow::Scraper.scrape_leagues.each do |league|
      FootballNow::League.create_from_hash(league)
    end
  end

  def self.create_teams
    FootballNow::League.all.each do |league|
      teams_hash(league.league_url).each do |team_hash|
        FootballNow::Team.create_from_hash(team_hash)
      end
    end
  end

  def self.teams_hash(league_url)
    FootballNow::Scraper.scrape_teams(league_url)
  end

  def self.create_matches
    FootballNow::League.all.each do |league|
      matches_hash(league.league_url).each do |match_hash|
        FootballNow::Team.create_from_hash(team_hash)
      end
    end
  end
end
