require "spec_helper"

describe ConnectFour do
  before(:each) do
    @game = ConnectFour.new
  end

  describe "#initialize" do
    it "exists" do
      expect(ConnectFour.new).to be_a ConnectFour
    end
  end

  describe "#main_menu & quitting game" do
    it "handles 'q'" do
      allow($stdin).to receive(:gets) { "q" }
      allow(@game).to receive(:abort)

      @game.main_menu

      expect(@game).to have_received(:abort)
    end

    it "handles bad input" do
      allow($stdin).to receive(:gets).and_return("f", "q")
      allow(@game).to receive(:abort)

      @game.main_menu

      expect(@game).to have_received(:abort)
    end
  end

  describe "#set_game_engine" do
    it "sets the correct engine based on user input" do
      allow($stdin).to receive(:gets) { "1P" }
      allow(@game).to receive(:start)
      @game.set_game_engine
      expect(@game.game_engine).to be_a GameEngine
    end

    it "sets the correct engine based for 2P" do
      allow($stdin).to receive(:gets) { "2P" }
      allow(@game).to receive(:start)
      @game.set_game_engine
      expect(@game.game_engine).to be_a MPGameEngine
    end
  end

  describe "#start" do
    context "when @game_engine is an instance of MPGameEngine" do
      it "calls loiter" do
        allow($stdin).to receive(:gets) { "2P" }
        allow(@game).to receive(:start)
        @game.set_game_engine
        RSpec::Mocks.space.proxy_for(@game).reset
        allow(@game.game_engine).to receive(:play_game)
        allow(@game).to receive(:main_menu)
        allow(@game).to receive(:loiter)

        @game.start

        expect(@game).to have_received(:loiter)
      end
    end

    context "when @game_engine is an instance of GameEngine" do
      it "does not call loiter" do
        allow($stdin).to receive(:gets) { "1P" }
        allow(@game).to receive(:start)
        @game.set_game_engine
        RSpec::Mocks.space.proxy_for(@game).reset
        allow(@game.game_engine).to receive(:play_game)
        allow(@game).to receive(:main_menu)
        allow(@game).to receive(:loiter)

        @game.start

        expect(@game).not_to have_received(:loiter)
      end
    end
  end
end
