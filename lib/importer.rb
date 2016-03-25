class FootballNow::Importer

  def self.generate
    create_leagues
  end

  def self.create_leagues
    FootballNow::Scraper.scrape_leagues.each do |league|
      FootballNow::League.create_from_hash(league)
    end
  end
end
