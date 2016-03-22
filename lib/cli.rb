class FootballNow::CLI

  def call
    welcome_screen

    case get_user_input
    when "exit"
      goodbye_message
    when "list leagues"
      list_leagues
    end

  end

  def welcome_screen
    puts "Welcome to Football Now"
    puts "You can:"
    puts " - type `list leagues` to list all leagues."
    puts " - type `exit` to quit now."
  end

  def list_leagues
    puts "\n\n"
    puts "Available Leagues:"
    puts "=================="
    FootballNow::League.all.each.with_index(1) {|league, index| puts "#{index}. #{league}"}
    puts ""
    puts "You can:"
    puts " - type `<#> recent results` for scores"
    puts " - type `<#> get standings` for the league table"
    puts " - type `<#> list teams` to explore a team indepth"
    puts " - type `exit` to quit now."
    puts ""
    puts "Usage: typing `2 list teams` will list all teams in Primera Division."
    puts ""
    puts "What would you like to do?"
  end

  def goodbye_message
    puts "Until next time!"
    exit 0
  end

  def get_user_input
    gets.strip
  end
end
