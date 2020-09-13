require 'json'

class UserInteraction
  CURRENT_PATH = File.dirname(__FILE__)
  FILE = File.read(CURRENT_PATH[0..-4] + '/data/messages.json')
  @data = JSON.parse(FILE)
  @interplay = @data['interplay'].freeze
  @errors = @data['errors'].freeze

  class << self
    attr_reader :interplay, :errors
  end

  def self.start_game
    puts
    puts interplay['START_MESSAGE']
    print interplay['ENTER_NAME']
    gets.chomp
  end

  def self.show_statistics(player)
    puts "\n\n============ #{player.balance} ============="
    puts "#{interplay['PLAYER_NAME']} #{player.name}"
    puts "#{interplay['CARDS']} #{player.show_cards.join(' ')}"
    puts "#{interplay['POINTS_QUANTITY']} #{player.score}"
    puts "=============================\n\n"
  end

  def self.choose_action(actions)
    puts interplay['CHOOSE_ACTION']
    actions.each_with_index { |action, index| puts "#{index + 1} #{action}" }
    print interplay['YOUR_CHOICE']
    choice = STDIN.gets.chomp.to_i
    choice -= 1
    result = actions[choice]
    result || choose_action(actions)
  end

  def self.win
    interplay['WIN']
  end

  def self.tie
    interplay['TIE']
  end

  def self.lose
    interplay['LOSE']
  end

  def self.restart?
    print interplay['RESTART']
    STDIN.gets.chomp.to_i == 1
  end

  def self.play_again?
    print interplay['PLAY_AGAIN']
    STDIN.gets.chomp.to_i == 1
  end

  def self.clear_screen
    Gem.win_platform? ? (system 'cls') : (system 'clear')
  end

  def self.bankrupt(player)
    puts player.name + ' ' + interplay['PLAYER_BANKRUPT']
  end
end
