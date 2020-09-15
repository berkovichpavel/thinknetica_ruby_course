require 'json'

class UserInteraction
  CURRENT_PATH = File.dirname(__FILE__)
  FILE = File.read(CURRENT_PATH[0..-4] + '/data/messages.json')

  attr_reader :interplay

  def initialize
    @interplay = JSON.parse(FILE)
  end

  def start_game
    puts
    puts interplay['START_MESSAGE']
    print interplay['ENTER_NAME']
  end

  def show_statistics(player)
    puts "\n\n============ #{player.balance} ============="
    puts "#{interplay['PLAYER_NAME']} #{player.name}"
    puts "#{interplay['CARDS']} #{player.show_cards.join(' ')}"
    puts "#{interplay['POINTS_QUANTITY']} #{player.score}"
    puts "=============================\n\n"
  end

  def choose_action(actions)
    puts interplay['CHOOSE_ACTION']
    actions.each_with_index { |action, index| puts "#{index + 1} #{action}" }
    print interplay['YOUR_CHOICE']
    choice = STDIN.gets.chomp.to_i
    choice -= 1
    result = actions[choice]
    result || choose_action(actions)
  end

  def win
    puts interplay['WIN']
  end

  def tie
    puts interplay['TIE']
  end

  def lose
    puts interplay['LOSE']
  end

  def restart?
    print interplay['RESTART']
    STDIN.gets.chomp.to_i == 1
  end

  def play_again?
    print interplay['PLAY_AGAIN']
    STDIN.gets.chomp.to_i == 1
  end

  def clear_screen
    Gem.win_platform? ? (system 'cls') : (system 'clear')
  end

  def bankrupt(player)
    puts player.name + ' ' + interplay['PLAYER_BANKRUPT']
  end

  def exit(player)
    puts "Bye, #{player.name}. " + interplay['LEAVE'] + player.balance.to_s
  end

  def error(error)
    puts interplay['ERROR'] + error.message
  end
end
