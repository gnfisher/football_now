class FootballNow::Scraper
  extend Capybara::DSL
  extend WaitForAjax

  BASE_URL = "http://www.soccer24.com"

  # Put this in a config later
  LEAGUES = ["Premier League", "Primera Division", "Bundesliga", "Serie A"]

  def self.scrape_leagues
    league_list = Nokogiri::HTML(open(BASE_URL)).css('.left-menu').first.css('ul li')

    league_list.map do |row|
      href      = row.css('a').attribute('href').value
      league    = row.css('a').text
      team_hash = {name: league, league_url: "#{BASE_URL}#{href}"}

      LEAGUES.include?(league) ? team_hash : nil
    end.compact
  end

  def self.scrape_teams(league_url)
    visit(get_standings_page_url(league_url))
    standings_page  = Nokogiri::HTML(page.html)
    standings       = standings_page.css('table#table-type-1 tbody tr')
    league          = standings_page.css('.tournament-name').text

    standings.map do |row|
      goals_for_against     = row.css('.goals').first.text.split(':')
      team_hash = {
        name:               row.css('.participant_name .team_name_span').text,
        league:             league,
        wins:               row.css('.wins').text,
        draws:              row.css('.draws').text,
        losses:             row.css('.losses').text,
        standing:           row.css('.rank').text.chomp('.'),
        goals_for:          goals_for_against[0],
        goals_against:      goals_for_against[1]
      }
    end
  end

  # Sleep() solution is wonky, but all leagues require at least two clicks of
  # of the Show more matches link... temp solution.
  def self.scrape_matches(league_url)
    visit(get_matches_page_url(league_url))
    click_link("Show more matches")
    sleep(2)
    click_link("Show more matches")
    sleep(2)

    matches_page = Nokogiri::HTML(page.body)
    rounds = matches_page.css('tr td').collect(&:text)

    # print rounds.compact.inspect
  end

  private

  def self.get_standings_page_url(league_url)
    league_page   = Nokogiri::HTML(open(league_url))
    href          = league_page.css('.page-tabs .ifmenu li a:contains("Standings")').attribute('href').value
    "#{BASE_URL}#{href}"
  end

  def self.get_matches_page_url(league_url)
    matches_page   = Nokogiri::HTML(open(league_url))
    href          = matches_page.css('.page-tabs .ifmenu li a:contains("Results")').attribute('href').value
    "#{BASE_URL}#{href}"
  end
end
