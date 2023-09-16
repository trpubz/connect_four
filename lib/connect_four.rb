# frozen_string_literal: true
require_relative "game_engine"
require_relative "multiplayer_game_engine"
require_relative "msg"
require_relative "ip_config"

class ConnectFour
  include IpConfig
  include MSG

  attr_reader :game_engine

  def initialize
    @game_engine = nil
  end

  def main_menu
    puts WELCOME_MSG
    play_quit = CLI.get_input
    # play_quit = "P" # testing
    if play_quit == "Q"
      abort(BYE_MSG)
    elsif play_quit == "P"
      puts PLAY_MSG
      set_game_engine
    else
      puts P_OR_Q_ERR_MSG
      main_menu
    end
  end

  # returns game engine MP or SP
  def set_game_engine
    puts ONEPLAYER_TWOPLAYER
    game_mode = CLI.get_input
    # game_mode = "2P" # testing
    if game_mode == "1P"
      @game_engine = GameEngine.new
    elsif game_mode == "2P"
      @game_engine = MPGameEngine.new
    else
      puts INPUT_ERR_MSG(game_mode)
      set_game_engine
    end
    start
  end

  def start
    loiter if @game_engine.instance_of?(MPGameEngine)
    @game_engine.play_game
    main_menu
  end

  def loiter
    # make initial curl request
    username = ENV["USER"]
    foe = ""
    p1 = ""
    # send /init request
    response = `curl -s "#{P2P_IP}/init?player=#{username}"`.chomp # => '...patient'
    until response == "start"
      print WAITING_MSG
      # send /start request; if game ready to start, will return foe
      response = `curl -s "#{P2P_IP}/start?player=#{username}"`.chomp
      if response.include?("start")
        start_responses = response.split(" ")
        foe = start_responses[1]
        p1 = start_responses[2]  # p1 used to set @current_player
        response = "start"
        break
      end
      LOADER_MSG(7)  # wait 7 seconds
    end

    puts ""
    puts OPP_FOUND
    @game_engine.player1 = Player.new(username, "X")
    @game_engine.player2 = Player.new(foe, "O")
    @game_engine.set_current_player(p1)
    print "game ready to start"
    LOADER_MSG(3)  # wait 3 seconds
  end
end

# ConnectFour.new.main_menu
