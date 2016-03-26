class FootballNow::DB
  extend Capybara::DSL

  def self.get_html(url, obj)
    # checks if html_file of URL is saved and not expired
    # if expired, scrapes and saves HTML file
    # returns html_file of URL
    file_path = file_path_from(url)
    if exists?(file_path) && not_expired?(file_path)
      # File.read(file_path)
    end

    send(obj, url)
  end

  def league(url)
  end

  def teams(url)
  end

  def matches(url)
  end
end
