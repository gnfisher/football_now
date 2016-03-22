require 'spec_helper'

describe 'FootballNow::League' do

  describe '#new_from_hash' do
    it 'takes a valid formatted hash and returns a League object instance' do
      league_hash = {name: "Premier League"}
      expect(FootballNow::League.new_from_hash(league_hash).name).to eq("Premier League")
    end
  end

  describe '#create_from_hash' do
    it 'takes a valid formatted hash and creates and saves a League object' do
      league_hash = {name: "Premier League"}
      league = FootballNow::League.create_from_hash(league_hash)
      expect(FootballNow::League.all).to include(league)
    end
  end
end
