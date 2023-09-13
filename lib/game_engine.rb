require_relative 'board'
require_relative 'player'
require_relative 'msg'
require_relative 'cli'

class GameEngine
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

  def play_game  # Player has hit 'p'
    game_over = false
    until game_over
      puts @board.display
      # keep false until valid input => in-range, un-filled column
      turn_over = false
      plyr = whose_turn
      token_x, token_y = nil, nil # returned from #drop_token and passed to #win_condition
      # if human player
      if plyr == @player1
        # force user to enter valid input
        until turn_over
          # only runs once (right after opponent takes turn)
          puts PLAYER_TURN_MSG
          column = CLI.get_input
          if valid_input(column)
            token_x, token_y = drop_token(column, plyr.token)
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
            token_x, token_y = drop_token(column, plyr.token)
            turn_over = true
          end
        end
      end
      if @board.check_win(token_x, token_y, plyr.token)
        puts @board.display
        puts "#{VICTORY_MSG(plyr.name)}"
        game_over = true
        main_menu
      end
      if @board.board_full?
        puts @board.display
        puts TIE_GAME_MSG
        game_over = true
        main_menu
      end
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
  def whose_turn
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
end

# session = GameEngine.new
# session.main_menu
