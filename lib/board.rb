class Board
  attr_reader :board

  def initialize(rows = 6, columns = 7)
    # board 'height'
    @num_rows = rows
    # board 'width'
    @num_columns = columns
    # Initialize an empty board filled with '.'
    @board = Array.new(@num_rows) { Array.new(@num_columns, ".") }
  end

  # return x, y coordinates
  def drop_token(column, token)
    col_idx = column_to_index(column)
    row_idx = @num_rows - 1
    @board.reverse_each do |row|
      if row[col_idx] == "."
        # animate dropping of token before return
        animate_token(col_idx, row_idx, token)
        row[col_idx] = token
        return col_idx, row_idx
      end
      row_idx -= 1
    end
  end

  def animate_token(col_idx, row_idx, token)
    row_idx.times do |i|
      sleep 0.26
      CLI.clear
      @board.each_with_index do |row, idx|
        pseudo_row = row.dup
        if idx == i
          pseudo_row[col_idx] = token
          puts pseudo_row.join(" ")
        else
          puts row.join(" ")
        end
      end
      # Print column numbers for easier reference
      puts COLUMNS[0...@num_columns].join(" ")
    end
    sleep 0.77
    CLI.clear
  end

  def display
    # Loop through each row and print it
    @board.each do |row|
      puts row.join(" ")
    end
    # Print column numbers for easier reference
    puts COLUMNS[0...@num_columns].join(" ")
  end

  def column_to_index(column)
    COLUMNS.index(column)
  end

  def board_full?
    !@board.flatten.include?(".")
  end

  def check_win(column, row, token)
    DIRECTIONS.each do |dx, dy|
      count = 1  # Start with the token just placed

      # Check one direction
      count += check_direction(column, row, dx, dy, token)
      # Check the opposite direction
      count += check_direction(column, row, -dx, -dy, token)

      return true if count >= 4  # Four or more in a row
    end
    false
  end

  def check_direction(column, row, dx, dy, token)
    count = 0
    x, y = column + dx, row - dy

    while y.between?(0, @num_rows - 1) && x.between?(0, @num_columns - 1) && @board[y][x] == token
      count += 1
      x += dx
      y -= dy
    end

    count
  end


  COLUMNS = %w[A B C D E F G]

  DIRECTIONS = [
    [0, 1],  # Horizontal
    [1, 0],  # Vertical
    [1, 1],  # Diagonal right
    [1, -1]  # Diagonal left
  ]
end
