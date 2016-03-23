class FootballNow::Scraper
  extend Capybara::DSL

  # Put these in config later
  BASE_URL = "http://www.soccer24.com"
  LEAGUES = ["Premier League", "Primera Division", "Bundesliga", "Serie A"]

  def self.scrape_leagues
    league_page = Nokogiri::HTML(open(BASE_URL))
    leagues = []

    league_page.css('.left-menu').first.css('ul li').each do |row|
      link_href = row.css('a').attribute('href').value
      league = row.css('a').text
      LEAGUES.each do |lg|
        leagues << {name: league, league_url: "#{BASE_URL}#{link_href}"} if lg[/#{league}/]
      end
    end

    leagues
  end

  def self.scrape_teams(league_url)
    visit(get_standings_page_url(league_url))
    standings_page = Nokogiri::HTML(page.html)

    teams = []

    standings_page.css('table#table-type-1 tbody tr').each do |row|
      goals_for_against = row.css('.goals').first.text.split(':')
      team_hash = {
        name:               row.css('.participant_name .team_name_span').text,
        league:             standings_page.css('.tournament-name').text,
        wins:               row.css('.wins').text,
        draws:              row.css('.draws').text,
        losses:             row.css('.losses').text,
        standing:           row.css('.rank').text.chomp('.'),
        goals_for:          goals_for_against[0],
        goals_against:      goals_for_against[1]
      }

      teams << team_hash
    end

    teams
  end

  private

  def self.get_standings_page_url(league_url)
    league_page = Nokogiri::HTML(open(league_url))
    standings_page_href = league_page.css('.page-tabs .ifmenu li a:contains("Standings")').attribute('href').value
    "#{BASE_URL}#{standings_page_href}"
  end

  def self.get_matches_page_url(league_url)
    # do stuff and return the url as a string
  end
end
