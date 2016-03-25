require 'spec_helper'

describe 'FootballNow::Importer' do

  describe '.generate' do
    it 'creates leagues, teams and matches' do
      FootballNow::Importer.generate

      expect(FootballNow::League.all.count).to be > 0
      expect(FootballNow::Team.all.count).to be > 0
      expect(FootballNow::Match.all.count).to be > 0
    end
  end
end
