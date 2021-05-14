# frozen_string_literal: true

# Handles the output of command line messages
module Output
  def print_welcome_banner
    print ' ' * 10
    puts ' ****************************** '
    print ' ' * 10
    puts ' *     Welcome to Hangman!    * '
    print ' ' * 10
    puts ' ****************************** '
    puts ''
  end

  def print_congratulations
    print "#{' ' * 12}***"
    print 'CONGRATULATIONS!'
    puts '***'
  end

  def game_overview
    <<~OVERVIEW
      In Hangman, you try to guess a secret word using a minimum of incorrect guesses.
      Each turn, you will be prompted to choose a letter to guess (or save your game).
      You get 8 incorrect guesses per game. Each time you guess a letter that is not in the word (and has not been \
      guessed before), one of these guesses gets used up.
      Each turn, the word will be displayed with the correctly guessed letters in-place, as well as the length of \
      the word and the letters that have been incorrectly guessed.
      If a letter is guessed twice, it will have no impact the second time it is guessed.
      For example, the word 'programming' with the letters 'r', 'g', 'm', and 'a' guessed would be displayed as \
      '_r_gramm__g'.
    OVERVIEW
  end
end
