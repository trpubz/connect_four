require 'spec_helper'

# frozen_string_literal: true

describe Board do
  before(:each) do
    @board = Board.new
  end

  describe "#initialize" do
    it "exists and has a board" do
      expect(@board).to be_a Board
      # columns
      expect(@board.board.size).to eq 6
      # rows
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
      expect(@board.board[5][0]).to eq(".")
      @board.drop_token("A", "X")
      expect(@board.board[5][0]).to eq("X")
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

  describe '#board_full' do
    it 'checks to see if no more moves can be made' do
      expect(@board.board_full?).to eq false
      @board.board.map!{ |row| row.map!{ |el| el = "X" } }
      @board.display
      expect(@board.board_full?).to eq true
    end
  end
end
