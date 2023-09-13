require 'game_engine'

class ConnectFour

  def initialize
    @game_engine = GameEngine.new
  end

  def start
    @game_engine.main_menu
  end
end