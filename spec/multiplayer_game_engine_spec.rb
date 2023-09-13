require 'spec_helper'


describe MPGameEngine do
  describe '#set_current_player'
    it 'sets current player' do
      ge = MPGameEngine.new
      ge.player1 = Player.new("tp")
      ge.player2 = Player.new("sebass", token = "O")
      ge.set_current_player("tp")
      expect(ge.current_player).to eq ge.player1
    end
end