# frozen_string_literal: true

require_relative 'game'
require_relative 'output'

# manages the flow of the application
class GameDriver
  include Output

  def initialize
    @quit = false
  end

  def run
    print_banner

    offer_explanation

    prompt_new_or_load until @quit

    say_goodbye
  end

  private

  def offer_explanation
    selection = prompt_for_selection(%i[y n], 'Would you like an explanation of the game? (y/n): ')
    puts selection == :y ? "\n#{explanation}" : "\n"
  end

  def prompt_new_or_load
    prompt = 'Would you like a (n)ew game, to (l)oad a previous save, or to (q)uit? (n/l/q): '
    selection = prompt_for_selection(%i[n l q], prompt)
    puts ''
    case selection
    when :n then setup_new_game
    when :l then handle_load_game
    when :q then @quit = true
    end
  end

  def say_goodbye
    puts 'Thank you for playing!'
  end

  # creates and runs a new game
  def setup_new_game
    Game.new.play
  end

  # handles a load game selection
  def handle_load_game
    game_name = prompt_for_game_name

    Game.new(game_name).play
  end

  # given a set of valid options (symbols) and a prompt, prints the prompt until user enters a valid selection
  def prompt_for_selection(options, prompt)
    print prompt
    selection = gets.chomp.to_sym

    until options.include? selection
      puts "\nSorry, that wasn't a valid selection."
      print prompt
      selection = gets.chomp.to_sym
    end

    selection
  end

  def prompt_for_game_name
    # TODO: implement this
    'placeholder.txt'
  end

  # print the explanation of the game
  def explanation
    "#{game_overview}\n"
  end
end
