require 'spec_helper'

# frozen_string_literal: true

describe Board do
  before(:each) do
    @board = Board.new
  end

  describe "#initialize" do
    it "exists and has a board" do
      expect(@board).to be_a Board
      expect(@board.board.size).to eq 6
      expect(@board.board[0].size).to eq 7
    end
  end

  describe '#display' do
    it 'prints the board with col designators' do
      @board.display
      # visually confirm 6x7 board with '.'
    end
  end
end
