class FootballNow::DB
  extend Capybara::DSL

  DB_PATH = "#{File.expand_path("..", __dir__)}/data"


  def self.get_html(url, obj_name)
    # checks if html_file of URL is saved and not expired
    # if expired, scrapes and saves HTML file
    # returns html_file of URL

    file_path = file_path_from(obj_name)

    if File.exists?(file_path) && not_expired?(file_path)
      File.read(file_path)
    end

    send("get_#{obj_name}_html", url)
  end

  def self.get_leagues_html(url)
    page_html = open(url).read
    leagues_file = open("#{DB_PATH}/leagues.html", "w")
    leagues_file.write(page_html)
    leagues_file.close
    page_html
  end

  def self.get_teams_html(url)
  end

  def self.get_matches_html(url)
  end

  def self.file_path_from(obj_name)
    "#{DB_PATH}/#{obj_name}.html"
  end

  def self.not_expired?(file_path)
    Time.now - File.mtime(file_path) < 86400
  end
end
