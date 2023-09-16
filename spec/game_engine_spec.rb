require "spec_helper"

describe GameEngine do
  before(:each) do
    @game = GameEngine.new
  end

  describe "#initialize" do
    it "exists" do
      expect(@game).to be_a(GameEngine)
    end
  end

  describe "@attributes" do
    it "has @players and @board" do
      expect(@game.players[0].name.length).to be >= 1
      expect(@game.players[1].name).to eq "HAL"
      expect(@game.board).to be_a Board
    end
  end

  describe "#valid_input" do
    it "validates input when board is empty" do
      expect(@game.valid_input("A")).to eq true
      expect(@game.valid_input("Z")).to eq false
    end

    it "validates room for token" do
      @game.board.board.each { |r| r[0] = "X" }
      expect(@game.valid_input("A")).to eq false
    end
  end

  describe "#whos_turn" do
    it "determines the turn" do
      expect(@game.whose_turn).to eq @game.player1
      expect(@game.current_player).to eq @game.ai
      expect(@game.whose_turn).to eq @game.ai
    end
  end
end
