require './lib/game_engine'

class ConnectFour
  def initialize(game_engine)
    @game_engine = game_engine
  end

  def start
    @game_engine.main_menu
  end
end

game_session = ConnectFour.new
game_session.start