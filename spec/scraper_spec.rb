require 'spec_helper'

describe 'FootballNow::Scraper' do
  describe '.scrape_leagues' do
    it 'creates array of League objects from url' do
      league_url = "http://www.soccer24.com"
      leagues = FootballNow::Scraper.scrape_leagues(league_url)
      
      expect(leagues.first[:name]).to eq("Premier League")
      expect(leagues.count).to eq(FootballNow::Scraper::LEAGUES.count)
    end
  end
end
