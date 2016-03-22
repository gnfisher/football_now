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

  def list_leagues
    puts (<<-EOT)
    1. Premier Leagues
    2. Primera Division
    3. Bundesliga
    4. Seria A
    EOT
  end

  def welcome_screen
    puts "Welcome to Football Now"
    puts "You can:"
    puts " - type `list leagues` to list all leagues."
    puts " - type `exit` to quit now."
  end

  def goodbye_message
    puts "Until next time!"
    exit 0
  end

  def get_user_input
    gets.strip
  end
end
