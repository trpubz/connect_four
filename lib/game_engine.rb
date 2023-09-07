require 'board'
require 'player'

class Game_Engine
  attr_reader :player1,
              :ai,
              :players,
              :board

  def initialize
    @player1 = Player.new(ENV['USER'], "X")
    @ai = Player.new("HAL", "O")
    @players = [@player1, @ai]
    @board = Board.new
  end

  def start_game
    system("echo", WELCOME_MSG)
  end


  WELCOME_MSG = "Let's play **** CONNECT FOUR ****
  Connect four of your checkers in a row while preventing your opponent from doing the same.\n
  press 'p' to play; 'q' to quit:"
end
