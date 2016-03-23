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
end
