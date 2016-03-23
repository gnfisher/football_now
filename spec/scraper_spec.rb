require 'spec_helper'

describe 'FootballNow::Scraper' do
  describe '.scrape_leagues' do
    it 'creates array of League objects from url' do
      leagues = FootballNow::Scraper.scrape_leagues

      expect(leagues.first[:name]).to eq("Premier League")
      expect(leagues.count).to eq(FootballNow::Scraper::LEAGUES.count)
    end
  end

  describe '.scrape_teams' do
    it 'creates an array of team objects from a league url' do
      league_url = "http://www.soccer24.com/england/premier-league/"
      teams = FootballNow::Scraper.scrape_teams(league_url)

      expect(teams.sort_by{|h| h[:name] }.first[:name]).to eq('Arsenal')
      # print teams.inspect
    end
  end
end
