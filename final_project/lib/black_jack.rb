require_relative 'user'
require_relative 'deck'
require_relative 'user_interaction'

class BlackJack
  RATE = 10
  DEALER_STOP_VALUE = 17
  INITIAL_MONEY = 20

  attr_reader :player, :dealer, :deck, :actions, :interface, :round_finished

  def initialize(interface)
    @interface = interface
    interface.clear_screen
    @dealer = User.new(name: 'Dealer', money: INITIAL_MONEY)
    interface.start_game
    name = STDIN.gets.chomp
    @player = User.new(name: name, money: INITIAL_MONEY)
    @round_finished = false
  end

  def restart
    interface.clear_screen
    self.dealer = User.new(name: 'Dealer', money: INITIAL_MONEY)
    self.player = User.new(name: player.name, money: INITIAL_MONEY)
    start_game
  end

  def start_game
    interface.clear_screen
    while money?
      init
      interface.show_statistics(player)
      decision_making until round_finished
      break unless play_again?
    end
    new_game
  end

  private

  attr_writer :player, :dealer, :deck, :actions, :round_finished

  def init
    deal_new_cards
    self.round_finished = false
    player.take_money(RATE)
    dealer.take_money(RATE)
  rescue ArgumentError => e
    puts "ERROR: #{e.message}"
  end

  def deal_new_cards
    self.deck = Deck.new
    self.actions = %i[take_card skip open_cards]
    player.new_game
    dealer.new_game
    add_card(player)
    add_card(dealer)
    add_card(player)
    add_card(dealer)
  end

  def add_card(player)
    player.add_card(deck.take_card)
  end

  def decision_making
    player_choice = interface.choose_action(actions)
    actions.delete(player_choice)
    add_card(dealer) if dealer.score < DEALER_STOP_VALUE
    method(player_choice).call unless player_choice == :open_cards
    open_cards if %i[take_card open_cards].include?(player_choice)
  end

  def take_card
    add_card(player)
    interface.show_statistics(player)
  end

  def skip; end

  def open_cards
    interface.show_statistics(dealer)
    method(winner_identifying).call
  end

  def play_again?
    interface.play_again?
  end

  def new_game
    loser = loser(player, dealer)
    interface.bankrupt(loser) if loser.balance.zero?
    interface.exit(player)
    interface.restart? ? restart : exit
  end

  def user_tie
    puts interface.tie
    player.add_money(RATE)
    dealer.add_money(RATE)
  end

  def user_win
    puts interface.win
    player.add_money(2 * RATE)
  end

  def user_lose
    puts interface.lose
    dealer.add_money(RATE)
  end

  def winner_identifying
    self.round_finished = true
    return :user_tie if player.score == dealer.score || tie?
    return :user_lose if player.score > 21
    return :user_win if dealer.score > 21
    return :user_win if player_win?

    :user_lose
  end

  def player_win?
    21 - player.score < 21 - dealer.score
  end

  def tie?
    player.score > 21 && dealer.score > 21
  end

  def loser(player1, player2)
    player1.balance.zero? ? player1 : player2
  end

  def money?
    player.balance.zero? || dealer.balance.zero? ? false : true
  end
end
