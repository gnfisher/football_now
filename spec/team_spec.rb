require 'spec_helper'

describe 'FootballNow::Team' do


  describe '#league=' do
    it 'assigns league to team and adds itself to the leagues array' do
      FootballNow::Team.reset
      league = FootballNow::League.new("Premier League", "www.league.com")
      liverpool = FootballNow::Team.new(name: "Liverpool")
      liverpool.save
      liverpool.league = league

      expect(league.teams).to include(liverpool)
      expect(liverpool.league).to eq(league)
    end
  end

  describe '#create_from_hash' do
    it 'takes a valid formatted hash and creates and saves a Team object' do
      FootballNow::Team.reset
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

  describe '.find_by_name' do
    it 'finds a team by name and returns suitable object or nil' do
      FootballNow::Team.reset
      liv = FootballNow::Team.new('Liverpool')
      liv.save

      expect(FootballNow::Team.find_team_by_name('liverpool')).to eq(liv)
    end
  end
end
