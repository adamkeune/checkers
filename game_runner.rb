require "./checkers"

game = Checkers.new

while game.board.flatten.any?("x") || game.board.flatten.any?("o")
  pp game.board

  puts "Player #{game.current_player}, which piece do you want to move?"
  puts "Row?"
  row1 = gets.chomp.to_i

  puts "Column?"
  column1 = gets.chomp.to_i

  puts "Move this piece to where?"
  puts "Row?"
  row2 = gets.chomp.to_i

  puts "Column?"
  column2 = gets.chomp.to_i

  game.move(row1, column1, row2, column2)
  # game.toggle_player(game.current_player)
end
