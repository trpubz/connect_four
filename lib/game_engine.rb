require './lib/board'
require './lib/player'
require './lib/msg'

class Game_Engine
  include MSG
  attr_reader :player1,
              :ai,
              :players,
              :board

  def initialize
    @player1 = Player.new(ENV['USER'], "X")
    @ai = Player.new("HAL", "O")
    @players = [@player1, @ai]
    @board = Board.new
    @cur_player = count_pieces(@board.board).even? ? @player1 : @ai
  end

  # def main_menu => handle logic to start game

  def main_menu
    system("echo", WELCOME_MSG)
    # require 'byebug'; byebug
    play_quit = STDIN.gets.chomp
    require 'byebug'; byebug
    if play_quit == "q"
      abort(BYE_MSG)
    elsif play_quit == "p"
      system("echo", PLAY_MSG)
      start_game
    else
      system("echo", P_OR_Q_ERR_MSG)
      main_menu
    end
  end

  def start_game  # Player has hit 'p'
    
  end
  # TODO Human Player is always 'X'
  
  def count_pieces(cur_board)
    cur_board.reduce(0) do |count, row|
      row.each do |el|
        el != "." ? count += 1 : count
      end  
      count
    end
  end

  def take_turn
    system("echo", "#{@cur_player}, you're up! Pick any column, A-G, to place your #{cur_player.token} game piece")
    column_selection = gets.chomp
    piece_placed = place_piece_on_board(column_selection)
    while !piece_placed
      piece_placed = place_piece_on_board
    end
  end

  def place_piece_on_board(selection)
    system("echo", PLAYER_TURN_MSG)
    return nil if !selection.upcase.include?("A".."G")
    @board.board[selection][0] = @cur_player.token
    require 'pry'; binding.pry
    # re-display board with @board.display after each successful turn
  end

  # TODO def check_winners 
      # code to check finite array OR
      # method that can check ver/hor/diag winners
      # will need to run (while loop or recursion) after 
      # every player turn. This will stop game from exiting
      # and automatically switch to next player until
      # winner determined
  # end

 

end

session = Game_Engine.new
session.start_game
# require 'pry'; binding.pry








# def select_player_piece
  #   system("echo", X_OR_O_MSG)
  #   player_token = gets.chomp
  #   if player_token == "X" 
  #     @player1.token = "X"
  #     @ai.token = "O"
  #   elsif player_token == "O"
  #     @player1.token = "O"
  #     @ai.token = "X"
  #   else
  #     system("echo", SELECT_PIECE_ERR_MSG)
  #     select_player_piece
  #   end
  # end