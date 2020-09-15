require_relative 'lib/deck'
require_relative 'lib/black_jack'

game = BlackJack.new(UserInteraction.new)
game.start_game
