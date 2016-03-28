class FootballNow::DB

  extend Capybara::DSL

  def self.get_html(url)
    url_array = strip_url(url)
    file_path = file_path_from(url_array)

    if File.exists?(file_path) && not_expired?(file_path)
      File.read(file_path)
    else
      return_html(url_array)
    end
  end

  def self.get_leagues_html(url)
    page_html = open(url).read
    url_array = strip_url(url)
    save_as_file(url_array, page_html)
    page_html
  end

  def self.get_standings_html(url)
    visit(url)
    sleep(1)

    url_array = strip_url(url)
    save_as_file(url_array, page.html)
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
    save_as_file(url_array, page.html)
    page.html
  end

  def self.file_path_from(url_array)
    url_array[1] == nil ? "#{FootballNow::DB_PATH}/leagues.html" :
      "#{FootballNow::DB_PATH}/#{url_array[2]}-#{url_array[3]}.html"
  end

  def self.not_expired?(file_path)
    Time.now - File.mtime(file_path) < FootballNow::TIME_OUT
  end

  def self.strip_url(url)
    url.gsub("http://", "").split("/")
  end

  def self.save_as_file(url_array, html)
    leagues_file = open(file_path_from(url_array), "w")
    leagues_file.write(html)
    leagues_file.close
  end

  def self.return_html(url_array)
    url_array[1] == nil ? get_leagues_html(url) : send("get_#{url_array[3]}_html", url)
  end
end
