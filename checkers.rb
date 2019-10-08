class Checkers
  attr_accessor :board, :current_player

  def initialize
    @board = [
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "x", " ", "x", " ", "x", " ", "x"],
      ["2", "x", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", "x", " ", "x", " ", "x", " ", "x"],
      ["4", " ", " ", " ", " ", " ", " ", " ", " "],
      ["5", " ", " ", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", "o", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "o", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "o", " ", "o", " "],
    ]
    @current_player = "x"
  end

  def toggle_player(player)
    if player == "x"
      @current_player = "o"
    else
      @current_player = "x"
    end
    @current_player
  end

  def king
    @board[1].each { |space| space.upcase! if space == "o" }
    @board[8].each { |space| space.upcase! if space == "x" }
    @board
  end

  def validate_king(row1, column1, row2, column2)
    @board[row1][column1] == current_player.upcase &&
    @board[row2][column2] == " "
  end

  def validate_move(row1, column1, row2, column2)
    (@board[row1][column1]) && (@board[row1][column1] == current_player) &&
      (@board[row2][column2] == " ")
  end

  def move(row1, column1, row2, column2)
    if validate_king(row1, column1, row2, column2)
      checker = @board[row1][column1]

      if (row1 - row2).abs == 1 &&
         (column1 - column2).abs == 1
        @board[row1][column1] = " "
        @board[row2][column2] = checker
        toggle_player(current_player)
        @board
      else
        "Invalid move"
      end
    elsif validate_move(row1, column1, row2, column2)
      checker = @board[row1][column1]

      if checker == "x"
        if row2 - row1 == 1 &&
           (column1 - column2).abs == 1
          @board[row1][column1] = " "
          @board[row2][column2] = checker
          toggle_player(current_player)
          @board
        else
          "Invalid move"
        end
      elsif checker == "o"
        if row1 - row2 == 1 &&
           (column1 - column2).abs == 1
          @board[row1][column1] = " "
          @board[row2][column2] = checker
          toggle_player(current_player)
          @board
        else
          "Invalid move"
        end
      end
    else
      "Invalid move"
    end
  end

  def jump(current_player, row1, column1, row2, column2)
    checker = @board[row1][column1]

    jumped_row = ((row1 + row2) / 2)
    jumped_column = ((column1 + column2) / 2)
    jumped_space = @board[jumped_row][jumped_column]

    if checker != " " &&
       @board[row2][column2] == " " &&
       (row1 - row2).abs == 2 &&
       (column1 - column2).abs == 2 &&
       jumped_space != " " &&
       jumped_space != current_player
      @board[row1][column1] = " "
      @board[jumped_row][jumped_column] = " "
      @board[row2][column2] = checker
      @board
    else
      "Invalid jump"
    end
  end

  def computer_checkers
    array_o = []
    i = 0
    while i < @board.length # refactor to .map, check documentation
      j = 0
      while j < @board[i].length
        array_o << [i, j] if @board[i][j] == "o"
        j += 1
      end
      i += 1
    end
    array_o
  end

  def computer_moves(arr)
    arr.filter do |space|
      k = space[0]
      l = space[1]
      @board[k - 1][l + 1] == " " ||
      @board[k - 1][l - 1] == " "
    end
  end

  def computer_jumps(arr)
    arr.filter do |space|
      k = space[0]
      l = space[1]
      (@board[k - 1][l + 1] == "x" &&
       @board[k - 2][l + 2] == " ") ||
      (@board[k - 1][l - 1] == "x" &&
       @board[k - 2][l - 2] == " ")
    end
  end

  def computer_turn
    # split into separate functions
    # find all "o"s, save [i, j] in array
    # filter all [i, j] for available jumps
    # filter all [i, j] for available moves
    # choose from filtered array
    # call 'move' or 'jump', return board
    jumps_array = computer_jumps(computer_checkers)
    moves_array = computer_moves(computer_checkers)

    if jumps_array.length > 0
      jump(current_player, jumps_array[0][0], jumps_array[0][1], (jumps_array[0][0] - 2), (jumps_array[0][1] - 2))
    else
      move(moves_array[0][0], moves_array[0][1], (moves_array[0][0] - 1), (moves_array[0][1] + 1))
    end
  end
end
