require "./checkers"

game = Checkers.new

while (game.board.flatten.any?("x") || game.board.flatten.any?("X")) && (game.board.flatten.any?("o") || game.board.flatten.any?("O"))
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

  game.move(row1, column1, row2, column2) if (row1 - row2).abs == 1
  game.jump(game.current_player, row1, column1, row2, column2) if (row1 - row2).abs == 2

  # game.toggle_player(game.current_player)
end
