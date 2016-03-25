class FootballNow::Importer

  def self.generate
    create_leagues
    puts "#{FootballNow::League.all.count} Leagues loaded..."
    create_teams
    puts "#{FootballNow::Team.all.count} Teams loaded..."
    create_matches
    puts "#{FootballNow::Match.all.count} Matches loaded..."
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
        FootballNow::Match.create_from_hash(match_hash)
      end
    end
  end

  def self.matches_hash(league_url)
    FootballNow::Scraper.scrape_matches(league_url)
  end
end
