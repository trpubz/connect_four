class Board
  attr_reader :board

  def initialize(rows = 6, columns = 7)
    @rows = rows
    @columns = columns
    # Initialize an empty board filled with '.'
    @board = Array.new(rows) { Array.new(columns, '.') }
  end

  def display
    # Loop through each row and print it
    @board.each do |row|
      puts row.join(' ')
    end
    # Print column numbers for easier reference
    # TODO Should board columns only go to G? (7 columns?? Each column with 6 elements representing vertical column?? e.g., A[0] reps bottom slot of A column)
    puts %w{A B C D E F G H I J K L M}[0...@columns].join(' ')
  end
end
require 'pry'; binding.pry