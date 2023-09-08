require './lib/board'
require './lib/player'

class Game_Engine
  attr_reader :player1,
              :ai,
              :players,
              :board

  def initialize
    @player1 = Player.new(ENV['USER'])
    @ai = Player.new("HAL", "O")
    @players = [@player1, @ai]
    @board = Board.new
  end

  def start_game
    system("echo", WELCOME_MSG)
    if gets.chomp.downcase == "q"
      abort(BYE_MSG)
    else
      system("echo", PLAY_MSG)
      if @player1.token == ""
        pick_piece
      end
    end
  end
  
  def pick_piece
    system("echo", X_OR_0_MSG)
    player_token = gets.chomp
      if player_token == "X" 
        @player1.token = "X"
      elsif player_token == "O"
        @player1.token = "O"
      else
        system("echo", "Sorry, I didn't understand that selection...")
        pick_piece
      end
    end
  end

  WELCOME_MSG = "Let's play **** CONNECT FOUR ****
  Connect four of your checkers in a row while preventing your opponent from doing the same.\n
  press 'p' to play; 'q' to quit:"

  PLAY_MSG = "#{ENV["USER"]} says we're playing Connect Four!!\n"
  "Human's First!! Start the game by picking any letter on the board!"

  BYE_MSG = "We hate goodbyes, #{ENV["USER"]}!! Hope you'll play Connect Four again soon!"

  X_OR_O_MSG = "Pick your piece! X or O??"
end

game = Game_Engine.new
game.start_game