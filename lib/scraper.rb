class FootballNow::Scraper
# Use class methods and Nokogiri to scrape everything.
  BASE_URL = "http://www.soccer24.com"
  LEAGUES = ["Premier League", "Primera Division", "Bundesliga", "Serie A"]

  def self.scrape_leagues(leagues_url)
    page = Nokogiri::HTML(open('http://www.soccer24.com'))
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
end
