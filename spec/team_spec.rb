require 'spec_helper'

describe 'FootballNow::Team' do

  describe '#league=' do
    it 'assigns league to team and adds itself to the leagues array' do
      league = FootballNow::League.new("Premier League", "www.league.com")
      team = FootballNow::Team.new(name: "Liverpool")
      team.league = league

      expect(league.teams).to include(team)
      expect(team.league).to eq(league)
    end
  end

  describe '#create_from_hash' do
    it 'takes a valid formatted hash and creates and saves a Team object' do
      league = FootballNow::League.new("Premier League", "www.league.com")
      team_hash = {
        name: "Liverpool",
        team_url: "url",
        league: league
      }

      team = FootballNow::Team.create_from_hash(team_hash)
      expect(FootballNow::Team.all).to include(team)
      expect(team.name).to eq("Liverpool")
      expect(team.league.name).to eq("Premier League")
      expect(league.teams).to include(team)
    end
  end
end
