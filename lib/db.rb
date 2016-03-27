class FootballNow::DB
  extend Capybara::DSL

  DB_PATH = "#{File.expand_path("..", __dir__)}/data"


  def self.get_html(url)
    # checks if html_file of URL is saved and not expired
    # if expired, scrapes and saves HTML file
    # returns html_file of URL
    url_array = strip_url(url)
    file_path = file_path_from(url_array)

    if File.exists?(file_path) && not_expired?(file_path)
      return File.read(file_path)
    end

    if url_array[1] == nil
      get_leagues_html(url)
    else
      send("get_#{url_array[3]}_html", url)
    end
  end

  def self.get_leagues_html(url)
    page_html = open(url).read
    url_array = strip_url(url)
    leagues_file = open(file_path_from(url_array), "w")
    leagues_file.write(page_html)
    leagues_file.close
    page_html
  end

  def self.get_standings_html(url)
    visit(url)
    sleep(1)

    url_array = strip_url(url)
    teams_file = open(file_path_from(url_array), "w")
    teams_file.write(page.html)
    teams_file.close
    page.html
  end

  def self.get_results_html(url)
    visit(url)
    sleep(1)
    click_link("Show more matches")
    sleep(2)
    click_link("Show more matches")
    sleep(2)

    url_array = strip_url(url)
    matches_file = open(file_path_from(url_array), "w")
    matches_file.write(page.html)
    matches_file.close
    page.html
  end

  def self.file_path_from(url_array)
    url_array[1] == nil ? "#{DB_PATH}/leagues.html" : "#{DB_PATH}/#{url_array[2]}-#{url_array[3]}.html"
  end

  def self.not_expired?(file_path)
    Time.now - File.mtime(file_path) < 86400
  end

  def self.strip_url(url)
    url.gsub("http://", "").split("/")
  end
end
