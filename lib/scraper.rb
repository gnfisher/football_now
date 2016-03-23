class FootballNow::Scraper
# Use class methods and Nokogiri to scrape everything.
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
    standings_page_url = "#{BASE_URL}#{standings_page_url}"

    

    # standings_page = Nokogiri::HTML(open(standings_page_url))
    # all_teams_rows = standings_page.css('.stats-table-container .stats-table.stats-main tbody tr')
    #
    # print all_teams_rows.inspect

    teams = []

    all_teams_rows.each do |row|
      team_hash = {
        name: row.css('td .participant_name .team_name_span').text
      }
      teams << team_hash
    end

    teams
  end
end
