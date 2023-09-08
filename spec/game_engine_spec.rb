require 'spec_helper'

# frozen_string_literal: true

describe Game_Engine do
  before(:each) do
    @game = Game_Engine.new
  end

  describe "#initialize" do
    it "exists" do
      expect(@game).to be_a(Game_Engine)
    end
  end

  describe '@attributes' do
    it 'has @players and @board' do
      expect(@game.players[0].name.length).to be >= 1
      expect(@game.players[1].name). to eq "HAL"
      expect(@game.board).to be_a Board
    end
  end

  describe '#main_menu quitting game' do
    xit 'handles \'q\'' do
      allow($stdin).to receive(:gets) {"q"}
      expect(@game.main_menu).to output(MSG.BYE_MSG).to_stdout
    end
  end

  describe '#main_menu bad input' do
    xit 'handles bad input' do
      allow($stdin).to receive(:gets).and_return("f", "q")
      expect(@game.main_menu).to output(MSG.BYE_MSG).to_stdout
    end
  end

  describe '#start_game' do
    it 'prints a welcome message' do
      expect(@game.start_game).to eq true
    end
  end
end
