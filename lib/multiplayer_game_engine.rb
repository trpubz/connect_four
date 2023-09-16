require_relative "board"
require_relative "player"
require_relative "msg"
require_relative "cli"
require_relative "ip_config"

class MPGameEngine
  include IpConfig
  include MSG

  attr_reader :board
  attr_accessor :player1,
    :player2,
    :current_player

  def initialize
    @player1 = nil
    @player2 = nil
    @current_player = nil
    @board = Board.new
  end

  def players
    [@player1, @player2]
  end

  def set_current_player(p1)
    @current_player = players.find { |player| player.name == p1 }
  end

  def play_game  # Player has hit 'p'
    game_over = false
    until game_over
      puts @board.display
      turn_over = false
      plyr = whose_turn
      token_x, token_y = nil, nil # returned from #drop_token and passed to #win_condition
      # local client
      if plyr == @player1
        input_received = false
        column = nil
        mutex = Mutex.new

        input_thread = Thread.new do
          puts PLAYER_TURN_MSG
          # keep false until valid input => in-range, un-filled column
          until turn_over
            ready = IO.select([$stdin], nil, nil, 1.6)  # 4th arg is 'release after time' (s)

            if ready
              column = $stdin.gets.chomp.upcase
              if valid_input(column)
                mutex.synchronize do
                  input_received = true
                  turn_over = true
                end
              else
                puts INPUT_ERR_MSG(column)
                # continue to run until local client enters valid input
                # loops back to until turn_over
              end
            end
          end
        end

        timer_thread = Thread.new do
          10.times do |i|
            print "#{10 - i}. . "
            sleep 1.6
            break if mutex.synchronize { input_received }
          end
          # if the player doesn't select a column, random valid selection will occur
          until turn_over
            column = Board::COLUMNS.sample
            if valid_input(column)
              puts TIMES_UP_MSG(column)
              mutex.synchronize do
                input_received = true
                turn_over = true
              end
            end
          end
        end

        [input_thread, timer_thread].each(&:join)

        token_x, token_y = drop_token(column, plyr.token)
        # send valid column selection to server
        `curl -s "#{P2P_IP}/move?player=#{plyr.name}?column=#{column}"`
      else  # remote client || @player2
        until turn_over
          11.times do
            puts WAITING_FOR_PLYR_MSG(plyr.name)
            response = `curl -s "#{P2P_IP}/status?player=#{@player1.name}"`.chomp
            # require 'pry'; binding.pry
            unless response.include?("patience")  # unless this fails => response == <valid letter>
              token_x, token_y = drop_token(response, plyr.token)
              turn_over = true
              break
            end
            sleep 1.6
          end
        end
      end

      if @board.check_win(token_x, token_y, plyr.token)
        puts @board.display
        puts VICTORY_MSG(plyr.name)
        game_over = true
      end

      if @board.board_full?
        puts @board.display
        puts TIE_GAME_MSG
        game_over = true
      end
    end
    sleep 1.6
    # send /reset command to server to clear out stored variables
    `curl -s "#{P2P_IP}/reset"`
  end

  def valid_input(column)
    idx = @board.column_to_index(column)
    Board::COLUMNS.include?(column) && @board.board[0][idx] == "."
  end

  # returns player object and increments queue
  def whose_turn
    plyr = @current_player
    @current_player = if plyr == players[0]
      players[1]
    else
      players[0]
    end
    plyr
  end

  def drop_token(column, token)
    @board.drop_token(column, token)
  end
end
