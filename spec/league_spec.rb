require 'spec_helper'

describe 'FootballNow::League' do

  describe '#new_from_hash' do
    it 'takes a valid formatted hash and returns a League object instance' do
      league_hash = {name: "Premier League"}
      expect(FootballNow::League.new_from_hash(league_hash).name).to eq("Premier League")
    end
  end

  describe '#create_from_hash' do
    # check @@all
  end
end
