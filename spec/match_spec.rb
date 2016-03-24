require 'spec_helper'

describe 'FootballNow::Match' do
  describe '#new' do
    it 'dynamically loads options inputed' do
      home_team = FootballNow::Team.new("Liverpool")
      options = { round: 21, date: "date" }
      options_two = { home_team: home_team, home_score: 100}
      match_one = FootballNow::Match.new(options)
      match_two = FootballNow::Match.new(options_two)

      expect(match_one.date).to eq("date")
      expect(match_one.home_team).to be_nil
      expect(match_two.home_team.name).to eq("Liverpool")
      expect(match_two.home_score).to eq(100)
      expect(match_two.away_score).to be_nil
    end
  end

  describe '#create_from_hash' do
    # it 'creates a new match object from hash provided' do
    #   home_team = FootballNow::Team.new("Liverpool")
    #   away_team = FootballNow::Team.new("Man Utd")
    #   match_hash = { home_team: home_team, away_team: away_team }
    #   match = FootballNow::Match.create_from_hash(match_hash)
    #
    #   expect(match.home_team.name).to eq("Liverpool")
    #   expect(match.away_team.name).to eq("Man Utd")
    #   expect(FootballNow::Match.all).to include(match)
    # end

    it 'creates a new match object form has provided' do
      FootballNow::Team.reset
      liverpool = FootballNow::Team.new("Liverpool")
      liverpool.save
      manutd = FootballNow::Team.new("Man Utd")
      manutd.save
      match_hash = {
        home_team: "Liverpool",
        away_team: "Man Utd",
        home_score: "100",
        away_score: "0"
      }

      match = FootballNow::Match.create_from_hash(match_hash)

      expect(match.home_score).to eq("100")
      expect(liverpool.matches).to include(match)
    end
  end
end
