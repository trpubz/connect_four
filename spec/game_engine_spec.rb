require 'spec_helper'

# frozen_string_literal: true

describe Game_Engine do
  before(:each) do
    @game = Game_Engine.new
  end

  describe "#initialize" do
    xit "exists" do
      expect(@game).to be_a(Game_Engine)
    end
  end

  describe '@attributes' do
    xit 'has @players and @board' do
      expect(@game.players[0].name.length).to be >= 1
      expect(@game.players[1].name). to eq "HAL"
      expect(@game.board).to be_a Board
    end
  end

  describe '#main_menu & quitting game' do
    xit 'handles \'q\'' do
      allow($stdin).to receive(:gets) {"q"}
      expect(@game.main_menu).to output(MSG.BYE_MSG).to_stdout
    end

    xit 'handles bad input' do
      allow($stdin).to receive(:gets).and_return("f", "q")
      expect(@game.main_menu).to output(MSG.BYE_MSG).to_stdout
    end
  end

  describe '#valid_input' do
    xit 'validates input when board is empty' do
      expect(@game.valid_input("A")).to eq true
      expect(@game.valid_input("Z")).to eq false
    end

    xit 'validates room for token' do
      # fill up column A index 0
      @game.board.board.each { |r| r[0] = "X" }
      # @game.board.display
      expect(@game.valid_input("A")).to eq false
    end
  end

  describe '#whos_turn' do
    it 'determines the turn' do
      # always start with human player
      expect(@game.whos_turn).to eq @game.player1
      expect(@game.current_player).to eq @game.ai
      expect(@game.whos_turn).to eq @game.ai
    end
  end

  # describe '#drop_token' do
  #   it 'updates board with token' do
      
  #   end
  # end

  describe '#win_condition' do
    it 'checks four or more of the same piece in each row' do
      4.times do |idx|
        @game.board.board[5][idx] = "X"
      end
      @board.display
      @game.win_condition
      require 'byebug'; byebug
      # expect(@game.win_condition).to be true
    end
  end
end
