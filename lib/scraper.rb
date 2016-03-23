class FootballNow::Scraper
# Use class methods and Nokogiri to scrape everything.

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
    # should take the league_url and generate list of team urls
    # should iterate through each team url creating a hash
    # return the hash
    league_page = Nokogiri::HTML(open(league_url))

    # team_page_href = league_page.css('.page-tabs .ifmenu li a:contains("Team")').attribute('href').value
    # team_page_url = "#{BASE_URL}#{team_page_href}"

    standings_page_href = league_page.css('.page-tabs .ifmenu li a:contains("Standings")').attribute('href').value
    standings_page_url = "http://www.soccer24.com/england/premier-league/standings/"  #"#{BASE_URL}#{standings_page_url}"

    visit(standings_page_url)
    # print page.html

    standings_page = Nokogiri::HTML(page.html)
    all_teams_rows = standings_page.css('table#table-type-1 tbody tr')

    teams = []

    all_teams_rows.each do |row|
      team_hash = {
        name: row.css('.participant_name .team_name_span').text
      }
      teams << team_hash
    end

    teams
  end
end
