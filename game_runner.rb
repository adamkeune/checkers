require "./checkers"

game = Checkers.new
pp game.board

while (game.board.flatten.any?("x") || game.board.flatten.any?("X")) && (game.board.flatten.any?("o") || game.board.flatten.any?("O"))
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

  if (row1 - row2).abs == 1 && (column1 - column2).abs == 1
    game.move(row1, column1, row2, column2)
    pp game.king
  elsif (row1 - row2).abs == 2 && (column1 - column2).abs == 2
    loop do
      game.jump(game.current_player, row1, column1, row2, column2)
      pp game.king

      puts "Jump again? (Y/N)"
      jump_again = gets.chomp

      if jump_again.downcase == "y"
        row1 = row2
        puts "Row?"
        row2 = gets.chomp.to_i

        column1 = column2
        puts "Column?"
        column2 = gets.chomp.to_i
      else
        break
      end
    end
    game.toggle_player(game.current_player)
  else
    pp "Invalid move"
  end
end

puts "#{game.current_player} wins!"
puts "Thanks for playing!"
