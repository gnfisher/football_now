class FootballNow::CLI

  def call
    welcome_screen
    list_leagues
  end

  def list_leagues
    puts "\n\n"
    puts "Available Leagues:"
    puts "=================="
    FootballNow::League.print_leagues
    puts ""
    puts "You can:"
    puts " - type `<#> recent results` for scores"
    puts " - type `<#> get standings` for the league table"
    puts " - type `<#> list teams` to explore a team indepth"
    puts " - type `exit` to quit now."
    puts ""
    puts "Usage: typing `1 list teams` will list all teams in the first league listed."
    puts ""
    puts "What would you like to do?"

    case input = get_user_input
    when "exit"
      goodbye_message
    when /^\D/
      puts "Sorry, I didn't understand..."
      list_leagues
    when /recent results/
      list_recent_results(input.split("").first.to_i - 1)
      list_leagues
    else
      puts "Sorry, I didn't understand..."
      list_leagues
    end
  end

  def list_recent_results(league_index)
    league  = FootballNow::League.get_league_by_index(league_index)

    puts ""
    puts "#{league.name.upcase}"
    puts "Round #{FootballNow::Match.most_recent_round_number(league)}:"
    puts ""

    FootballNow::Match.get_recent_results(league).each do |result|
      puts " #{result.home_score} #{result.home_team.name}"
      puts " #{result.away_score} #{result.away_team.name}"
      puts ""
    end
  end

  def welcome_screen
    puts "Welcome to Football Now"
    load_all_data
  end

  def load_all_data
    puts "Loading data from www.soccer24.com..."
    puts "This may take a minute or two..."
    FootballNow::Importer.generate
  end

  def goodbye_message
    puts "Until next time!"
    exit 0
  end

  def get_user_input
    gets.strip
  end
end
