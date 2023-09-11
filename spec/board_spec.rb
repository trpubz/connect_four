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
      expect(@board.drop_token("A", "X")).to eq([0, 5])
      expect(@board.board[5][0]).to eq("X")
      expect(@board.drop_token("B", "X")).to eq [1, 5]
      expect(@board.drop_token("A", "X")).to eq [0, 4]
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
      expect(@board.board_full?).to eq true
    end
  end

  describe '#check_direction' do
    it 'checks horizontal direction' do
      @board.drop_token("A", "X")
      @board.drop_token("B", "X")
      expect(@board.check_direction(5, 0, 1, 0, 'X')).to eq 1
    end

    it 'checks from last dropped token in reverse direction' do
      %w{A B C D}.each { |slot| @board.drop_token(slot, "X") }
      expect(@board.check_direction(5, 3, -1, 0, 'X')).to eq 3
    end

    it 'checks vertical direction up&down' do
      4.times{@board.drop_token("A", "X")}
      expect(@board.check_direction(5, 0, 0, 1, 'X')).to eq 3
      expect(@board.check_direction(2, 0, 0, -1, 'X')).to eq 3
    end

    it 'checks diagnal upright/downleft' do
      @board.board[5] = %w{X O O O . . .}
      @board.board[4] = %w{. X O O . . .}
      @board.board[3] = %w{. . X O . . .}
      @board.board[2] = %w{. . . X . . .}
      expect(@board.check_direction(5, 0, 1, 1, "X")).to eq 3
      expect(@board.check_direction(2, 3, -1, -1, "X")).to eq 3
    end

    it 'checks diagnal upleft/downright' do
      @board.board[5] = %w{X O O O . . .}
      @board.board[4] = %w{. X O O . . .}
      @board.board[3] = %w{. O X O . . .}
      @board.board[2] = %w{O . . X . . .}
      expect(@board.check_direction(5, 3, -1, 1, "O")).to eq 3
      expect(@board.check_direction(2, 0, 1, -1, "O")).to eq 3
    end
  end

  describe '#check_win' do
    it 'checks wins in the horizontal direction' do
      %w{A B C D}.each { |slot| @board.drop_token(slot, "X") }

    end
  end
end
