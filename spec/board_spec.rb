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

  describe '#column_to_index' do
    it 'returns the column index selected by player' do
      expect(@board.column_to_index("A")).to eq(0)
    end
  end

  describe '#drop_token' do
    it 'drops token onto board' do
      @board.drop_token("A", "X")
      # visual confirmation
      @board.display
    end

    it 'drops token onto token' do
      @board.board[5][0] = "X"
      @board.drop_token("A", "X")
      # visual confirmation
      @board.display
    end
  end
end
