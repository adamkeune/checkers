require "./checkers"

game = Checkers.new
puts "How many players? (1 or 2)"
answer = gets.chomp

if answer == "1"
  pp game.board
  while true
    if game.current_player == "x"
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

      if game.validate_move(row1, column1, row2, column2)
        game.move(row1, column1, row2, column2)
        game.toggle_player(game.current_player)
        pp game.king
      elsif game.validate_jump(row1, column1, row2, column2)
        # Next two lines: in or out of loop?
        game.jump(row1, column1, row2, column2)
        pp game.king
        loop do
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
            game.toggle_player(game.current_player)
            break
          end
        end
      else
        pp "Invalid move"
      end

      if !(game.board.flatten.any?("o") || game.board.flatten.any?("O"))
        puts "You win!"
        break
      else
      end
    else
      puts "My turn!"
      game.computer_turn # TODO: add multiple jumps for computer
      pp game.king

      if !(game.board.flatten.any?("x") || game.board.flatten.any?("X"))
        puts "I win!"
        break
      else
        game.toggle_player(game.current_player)
      end
    end
  end
  puts "Thanks for playing!"
elsif answer == "2"
  pp game.board

  while (game.board.flatten.any?("x") || game.board.flatten.any?("X")) && (game.board.flatten.any?("o") || game.board.flatten.any?("O"))
    # write method to check board for both tokens
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

    if game.validate_move(row1, column1, row2, column2) # (row1 - row2).abs == 1 && (column1 - column2).abs == 1
      game.move(row1, column1, row2, column2)
      pp game.king
    elsif game.validate_jump(row1, column1, row2, column2) # (row1 - row2).abs == 2 && (column1 - column2).abs == 2
      loop do
        game.jump(row1, column1, row2, column2)
        pp game.king

        puts "Jump again? (Y/N)"
        jump_again = gets.chomp

        if jump_again.downcase == "y"
          row1 = row2
          puts "Jump to which row?"
          row2 = gets.chomp.to_i

          column1 = column2
          puts "Jump to which column?"
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

  puts "Player #{game.current_player} loses!"
  game.toggle_player(game.current_player)
  puts "Player #{game.current_player} wins!"
  puts "Thanks for playing!"
else
  puts "Invalid entry"
end
