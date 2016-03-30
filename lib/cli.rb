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

    input = get_user_input
    league  = FootballNow::League.get_league_by_index(input.split("").first.to_i - 1) if input =~ /^\d/

    case input
    when "exit"
      goodbye_message
    when /^\D/
      puts "Sorry, I didn't understand..."
      list_leagues
    when /recent results/
      list_recent_results(league)
      list_leagues
    when /get standings/
      get_standings(league)
    when /list teams/
      list_teams(league)
    else
      puts "Sorry, I didn't understand..."
      list_leagues
    end
  end

  def list_recent_results(league)
    puts ""
    puts "#{league.name.upcase}"
    puts "Round #{league.current_round}:"
    puts ""

    FootballNow::Match.get_recent_results(league).each do |result|
      puts " #{result.home_score} #{result.home_team.name}"
      puts " #{result.away_score} #{result.away_team.name}"
      puts ""
    end

    puts "Hit enter to go back or exit to quit."
    goodbye_message if get_user_input.downcase == "exit"
  end

  def get_standings(league)
    table  = league.get_standings

    puts ""
    puts "#{league.name.upcase} : Up to Round #{league.current_round}"
    puts "=========================================="
    print_table(table)
    puts ""
    puts "Hit enter to return to league list or exit to quit."

    get_user_input.downcase == "exit" ? goodbye_message : list_leagues
  end

  def list_teams(league)
    puts ""
    puts "#{league.name.upcase} : Up to Round #{league.current_round}"
    puts ""

    format = '%-4s %-20s'
    league.teams.sort_by{|team| team.name}.each_with_index do |team, index|
      puts format % [index + 1, team.name]
    end

    puts ""
    puts "You can:"
    puts " - type `<#> results` for all results"
    puts " - type `<#> stats` for all avaulable stats"
    puts " - type `back` to return to the first menu"
    puts " - type `exit` to quit now."
    puts ""
    puts "Usage: typing `1 results` will list all results for that team."
    puts ""
    puts "What would you like to do?"

    input = get_user_input
    team = league.teams.sort_by{|team| team.name}[input.to_i - 1] if input =~ /^\d/

    case input
    when /results/
      list_all_results(team)
      list_teams(league)
    when /stats/
      list_stats(team)
      list_teams(league)
    when /back/
      list_leagues
    when /exit/
      goodbye_message
    else
      puts "Sorry, I didn't understand you."
      list_teams(league)
    end
  end

  def list_all_results(team)
    puts ""
    puts "#{team.name.upcase}: League Results"
    puts ""
    team.matches.each do |match|
      puts "Round #{match.round}:"
      puts " #{match.home_score} #{match.home_team.name}"
      puts " #{match.away_score} #{match.away_team.name}"
      puts ""
    end

    puts "Hit enter to go back or exit to quit."
    goodbye_message if get_user_input.downcase == "exit"
  end

  def list_stats(team)
    puts ""
    puts "#{team.name.upcase}: League Stats"
    puts ""
    format = '%-5s %-5s %-8s %-10s %-10s %-13s %s'
    puts format % ['Wins', 'Draws', 'Losses', 'Points', 'Goals For', 'Goals Against', 'Matches Played']
    puts format % [ team.wins, team.draws, team.losses, team.points, team.goals_for, team.goals_against, team.matches.size ]
    puts "Hit enter to go back or exit to quit."
    goodbye_message if get_user_input.downcase == "exit"
  end

  def print_table(table)
    format = '%-4s %-20s %-3s %-3s %-3s %s'
    puts format % ['#', 'Team', 'W', 'D', 'L', 'Pts']
    table.each do |team|
      puts format % [ team.standing, team.name, team.wins, team.draws, team.losses, team.points]
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
