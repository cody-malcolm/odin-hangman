# frozen_string_literal: true

require_relative 'output'

# manages the Game state (for a single Game)
class Game
  include Output

  def initialize(filename = nil)
    if filename.nil?
      @secret_word = load_secret_word
      @guessed_characters = []
    else
      # TODO: implement this
      @secret_word = 'hola'
      @guessed_characters = %i[h o l y]
    end

    @total_guesses = 8
  end

  def play
    take_turn until game_over?

    handle_game_over
  end

  private

  def load_secret_word
    # TODO: Add else handling
    dictionary = File.readlines('5desk.txt') if File.exist?('5desk.txt')
    dictionary.filter { |line| line.strip.length.between?(5, 12) }.sample.downcase.strip
  end

  def calculate_remaining_guesses
    # number of characters in guessed_characters that are not in secret_word
    @total_guesses - @guessed_characters.count { |c| !@secret_word.include?(c.to_s) }
  end

  def game_over?
    # if all letters in word are guessed or calculate_remaining_guesses == 0
    redacted_word == @secret_word || calculate_remaining_guesses.zero?
  end

  def handle_game_over
    if calculate_remaining_guesses.zero?
      puts "Sorry, you're out of guesses! The secret word was '#{@secret_word}'."
    else
      print_congratulations
      puts "You guessed the secret word! (#{@secret_word})"
    end
    puts ''
  end

  def take_turn
    print_status

    selection = prompt_for_guess

    if selection == :save
      handle_save
    elsif selection.length > 1
      puts 'Please guess only a single letter, or "save"'
    else
      handle_guess(selection)
    end

    puts ''
  end

  def handle_save
    # TODO: implement this
  end

  def handle_guess(guess)
    if @guessed_characters.include?(guess)
      puts "'#{guess}' was already guessed!"
    else
      handle_new_guess(guess)
    end
  end

  def handle_new_guess(guess)
    if @secret_word.chars.include?(guess.to_s)
      puts "'#{guess}' was in the secret word!"
    else
      puts "'#{guess}' was not in the secret word."
    end

    @guessed_characters.push(guess)
  end

  def print_status
    puts "The secret word is: #{redacted_word} (#{@secret_word.length} letters)"
    puts "The letters that have been guessed are: #{@guessed_characters.join(' ')}"
    puts "You have #{calculate_remaining_guesses} guesses remaining."
  end

  # calculate the secret word, with unguessed letters as '_'
  def redacted_word
    @secret_word.chars.map { |c| @guessed_characters.include?(c.to_sym) ? c : '_' }.join('')
  end

  def prompt_for_guess
    print 'Please guess a letter (or type "save" to save the game): '
    gets.chomp.downcase.to_sym
  end
end
