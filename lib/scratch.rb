require './board'

new_board = Board.new
# completely populate board with randomly placed 'X's and 'O's
new_board.board.map!{ |row| row.map!{ |el| el = ['X', 'O'].sample }}
# display populated board to see if #win_condition methods are working
new_board.display

# horizontal condition working
# def win_condition(board)
  # def horizWinner(board)
  #   piece = nil
  #   board.board.each.with_index do |row, idx|
  #     if row.join("").include?("XXXX")
  #       piece = "X"
  #       return [true, piece, idx]
  #     end
  #     if row.join("").include?("OOOO")
  #       piece = "O"
  #       return [true, piece, idx]
  #     end
  #   end
  #   return false
  # end
  # winner_across = horizWinner(board)
  # if winner_across
  #   # row 1 = top; row 2 = 2nd from top; row 3 = 3rd from top...
  #   puts "`#{winner_across[1]}` Wins! with (at least) 4 across on row: #{winner_across[2]+1}"
  #   return true
  # else
  #   puts "No winners `across`"
  #   return false
  # end



#   def vertWinner(board)
#     piece = nil
#     col_arrays = []
#     board.board.each do |row|
#       temp_arr = []
#       row.each do |el|
#         temp_arr << el
#       end
#       col_arrays << temp_arr
#     end
#     col_arrays
#     # if col_array.join("").include("XXXX")
#     #   piece = "X"
#     #   return [true, piece, idx]
#     # end
#   end
#   vertWinner(board)
# end

# p win_condition(new_board)

