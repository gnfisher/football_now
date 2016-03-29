module FootballNow
  VERSION = "0.1.5"

  # Football Now Config options
  #
  # DB_PATH
  # Folder in the directory where scraped HTML pages are saved.
  DB_PATH = "#{File.expand_path("../..", __dir__)}/data"

  # TIME_OUT
  # The number of seconds that a saved copy of the HTML file is valid for.
  # Default = 24 hours
  TIME_OUT = 86400
end
