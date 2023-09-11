require './lib/board'
require './lib/player'
require './lib/msg'
require './lib/cli'
require 'byebug'

class Game_Engine
  include MSG
  attr_reader :player1,
              :ai,
              :players,
              :current_player,
              :board,
              :piece_count

  def initialize
    @player1 = Player.new(ENV['USER'], "X")
    @ai = Player.new("HAL", "O")
    @players = [@player1, @ai]
    @board = Board.new
    @current_player = @players[0]
  end

  def main_menu
    puts WELCOME_MSG
    play_quit = CLI.get_input
    if play_quit == "Q"
      abort(BYE_MSG)
    elsif play_quit == "P"
      puts PLAY_MSG
      play_game
    else
      puts P_OR_Q_ERR_MSG
      main_menu
    end
  end

  def play_game  # Player has hit 'p'
    until win_condition || board_full
      puts @board.display
      # keep false until valid input => in-range, un-filled column
      turn_over = false
      plyr = whos_turn
      # if human player
      if plyr == @player1
        # force user to enter valid input
        until turn_over
          # only runs once (right after opponent takes turn)
          puts PLAYER_TURN_MSG
          column = CLI.get_input
          if valid_input(column)
            drop_token(column, plyr.token)
            turn_over = true
          else
            # continue to run until HUMAN user enters valid input
            puts INPUT_ERR_MSG(column)
          end
        end
      else
        # computer's turn
        # TODO trash talk
        # keep false until computer picks unfilled column (idx always in-range)
        until turn_over
          column = Board::COLUMNS.sample
          if valid_input(column)
            drop_token(column, plyr.token)
            turn_over = true
          end
        end
      end
    end
    if board_full?
      # print TIE_GAME_MSG
      # call main_menu to run play_quit (should not display WELCOME_MSG. Only 'play' or 'quit' message)
    end
    if win_condition
    # print victory message
    end
  end

  def valid_input(column)
    idx = @board.column_to_index(column)
    if Board::COLUMNS.include?(column) && @board.board[0][idx] == '.'
      return true
    else
      return false
    end
  end

  # returns player object and increments queue
  def whos_turn
    plyr = @current_player

    if plyr == @players[0]
      @current_player = @players[1]
    else
      @current_player = @players[0]
    end

    return plyr
  end

  def drop_token(column, token)
    idx = @board.column_to_index(column)
    @board.drop_token(column, token)
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
    puts PLAYER_TURN_MSG
    return nil if !selection.upcase.include?("A".."G")
    @board.board[selection][0] = @cur_player.token
    # re-display board with @board.display after each successful turn
  end


  # return true/false
  def win_condition
    winner = false
    def horizWinner
      @board.board.each do |row|
        if row.join("").scan(/X{4,7}?/) || row.join("").scan(/O{4,7}?/)
          winner = true
          return
        end
      end
    end
    return winner
    horizWinner
  end

  # TODO: Iteration 3 REQs - Winner or Tie?
  # #win_condition method to check winner or full board
  # finite array OR method? while loop or recursion? 
  # #win_condition triggered by every call to #play_game 
  # 'next' player can't take turn until win_condition checked
  # and winner or tie determined.

end

# session = Game_Engine.new
# session.main_menu
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
