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

  describe '#start_game' do
    it 'prints a welcome message' do
      expect(@game.start_game).to eq true
    end
  end
end
