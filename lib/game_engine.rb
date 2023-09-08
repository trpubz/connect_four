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
    play_quit = gets.chomp
    if play_quit == "q"
      abort(BYE_MSG)
    elsif play_quit == "p"
      system("echo", PLAY_MSG)
      while @player1.token == ""
        pick_piece
      end
      # TODO set_piece 
    else
      system("echo", P_OR_Q_ERR_MSG)
    end
  end
  
  def pick_piece
    system("echo", X_OR_O_MSG)
    player_token = gets.chomp
    # player_token = "X"
    if player_token == "X" 
      @player1.token = "X"
      return
    elsif player_token == "O"
      @player1.token = "O"
      return
    else
      system("echo", PICK_PIECE_ERR_MSG)
      pick_piece
    end
  end

  def count_pieces(cur_board)
    cur_board.board.reduce(0) do |count, row|
      row.each do |el|
        el != "." ? count += 1 : count
      end  
      count
    end
  end

  def place_piece
    cur_player = count_pieces(@board).odd ? @ai : @player1
    system("echo", "#{cur_player}, you're up! Pick any column, A-G, to place your #{cur_player.token} game piece")
  end

  WELCOME_MSG = "Let's play **** CONNECT FOUR ****
  Connect four of your checkers in a row while preventing your opponent from doing the same.\n
  press 'p' to play; 'q' to quit:"

  PLAY_MSG = "#{ENV["USER"]} says we're playing Connect Four!!\n"
  "Human's First!! Start the game by picking any letter on the board!"

  BYE_MSG = "I hate goodbyes, #{ENV["USER"]}!! Hope you'll play Connect Four again soon!"

  X_OR_O_MSG = "Pick your piece! X or O??"

  P_OR_Q_ERR_MSG = "Sorry, I didn't understand that selection. press 'p' to play; 'q' to quit:"

  PICK_PIECE_ERR_MSG = "Sorry, I didn't understand that selection."

end

session = Game_Engine.new
session.start_game
# require 'pry'; binding.pry