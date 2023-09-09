class Board
  attr_reader :board

  def initialize(rows = 6, columns = 7)
    @num_rows = rows
    @num_columns = columns
    # Initialize an empty board filled with '.'
    @board = Array.new(@num_rows) { Array.new(@num_columns, '.') }
  end

  def drop_token(column, token)
    idx = column_to_index(column)
    @board.reverse_each do |row|
      if row[idx] == "."
        row[idx] = token
        return
      end
    end
  end

  def display
    # Loop through each row and print it
    @board.each do |row|
      puts row.join(' ')
    end
    # Print column numbers for easier reference
    puts COLUMNS[0...@num_columns].join(' ')
  end

  def column_to_index(column)
    COLUMNS.index(column)
  end

  COLUMNS = %w{A B C D E F G}
end
