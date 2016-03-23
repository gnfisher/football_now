class FootballNow::Scraper
  extend Capybara::DSL

  BASE_URL = "http://www.soccer24.com"
  LEAGUES = ["Premier League", "Primera Division", "Bundesliga", "Serie A"]

  def self.scrape_leagues(leagues_url)
    page = Nokogiri::HTML(open(BASE_URL))
    leagues = []

    top_leagues = page.css('.left-menu').first.css('ul li')

    top_leagues.each do |menu_element|
      link_href = menu_element.css('a').attribute('href').value
      league = menu_element.css('a').text
      LEAGUES.each do |l|
        leagues << collect_league_data(league, link_href) if l[/#{league}/]
      end
    end

    leagues
  end

  def self.collect_league_data(league, link_href)
    { name: league, league_url: "#{BASE_URL}#{link_href}"}
  end

  def self.scrape_teams(league_url)
    visit(get_standings_page_url(league_url))
    standings_page = Nokogiri::HTML(page.html)
    all_teams_rows = standings_page.css('table#table-type-1 tbody tr')

    teams = []

    all_teams_rows.each do |row|
      goals_for_against = row.css('.goals').first.text.split(':')
      team_hash = {
        name: row.css('.participant_name .team_name_span').text,
        wins: row.css('.wins').text,
        draws: row.css('.draws').text,
        losses: row.css('.losses').text,
        standing_in_league: row.css('.rank').text.chomp('.'),
        goals_for: goals_for_against[0],
        goals_against: goals_for_against[1]
      }

      teams << team_hash
    end

    teams
  end

  def self.get_standings_page_url(league_url)
    league_page = Nokogiri::HTML(open(league_url))
    standings_page_href = league_page.css('.page-tabs .ifmenu li a:contains("Standings")').attribute('href').value
    "#{BASE_URL}#{standings_page_href}"
  end
end
