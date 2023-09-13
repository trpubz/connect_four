require 'spec_helper'

# frozen_string_literal: true

describe ConnectFour do
  # before(:each) do
  #   @game = ConnectFour.new
  # end

  describe "#initialize" do
    xit "exists" do
      expect(ConnectFour.new).to be_a ConnectFour
    end
  end

  describe '#set_game_engine' do
    it 'sets the correct engine based on user input' do
      allow($stdin).to receive(:gets) { "1P" }
      game = ConnectFour.new
      expect(game.game_engine).to be_a GameEngine
    end

    it 'sets the correct engine based for 2P' do
      allow($stdin).to receive(:gets) { "2P" }
      game = ConnectFour.new
      expect(game.game_engine).to be_a MPGameEngine
    end
  end
end
