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
    (@board[row1][column1].downcase == current_player) &&
    (@board[row2][column2] == " ") &&
    (row1 - row2).abs == 1 &&
    (column1 - column2).abs == 1
  end

  def validate_jump(row1, column1, row2, column2)
    jumped_row = (row1 + row2) / 2
    jumped_column = (column1 + column2) / 2

    @board[row1][column1].downcase == current_player &&
    @board[row2][column2] == " " &&
    @board[jumped_row][jumped_column] != current_player &&
    @board[jumped_row][jumped_column] != current_player.upcase &&
    @board[jumped_row][jumped_column] != " " &&
    (row1 - row2).abs == 2 &&
    (column1 - column2).abs == 2
  end

  def move(row1, column1, row2, column2) # refactor to != and DRY
    checker = @board[row1][column1]
    if validate_king(row1, column1, row2, column2)
      if (row1 - row2).abs == 1 &&
         (column1 - column2).abs == 1
        @board[row1][column1] = " "
        @board[row2][column2] = checker
        @board
      else
        "Invalid move"
      end
    elsif validate_move(row1, column1, row2, column2)
      if checker == "x"
        if row2 - row1 == 1 &&
           (column1 - column2).abs == 1
          @board[row1][column1] = " "
          @board[row2][column2] = checker
          @board
        else
          "Invalid move"
        end
      elsif checker == "o"
        if row1 - row2 == 1 &&
           (column1 - column2).abs == 1
          @board[row1][column1] = " "
          @board[row2][column2] = checker
          @board
        else
          "Invalid move"
        end
      end
    else
      "Invalid move"
    end
  end

  def jump(row1, column1, row2, column2) # refactor to != and DRY
    checker = @board[row1][column1]
    jumped_row = ((row1 + row2) / 2)
    jumped_column = ((column1 + column2) / 2)
    jumped_space = @board[jumped_row][jumped_column]

    if validate_king(row1, column1, row2, column2) &&
       validate_jump(row1, column1, row2, column2)
      if (row1 - row2).abs == 2 &&
         (column1 - column2).abs == 2
        @board[row1][column1] = " "
        @board[jumped_row][jumped_column] = " "
        @board[row2][column2] = checker
        @board
      else
        p "Invalid jump"
      end
    elsif validate_jump(row1, column1, row2, column2)
      if checker == "x"
        if row2 - row1 == 2 &&
           (column1 - column2).abs == 2
          @board[row1][column1] = " "
          @board[jumped_row][jumped_column] = " "
          @board[row2][column2] = checker
          @board
        else
          p "Invalid jump"
        end
      elsif checker == "o"
        if row1 - row2 == 2 &&
           (column1 - column2).abs == 2
          @board[row1][column1] = " "
          @board[jumped_row][jumped_column] = " "
          @board[row2][column2] = checker
          @board
        else
          p "Invalid jump"
        end
      end
    else
      p "Invalid jump"
    end
  end

  def computer_checkers
    array_o = []
    i = 0
    while i < @board.length # refactor to .map
      j = 0
      while j < @board[i].length
        array_o << [i, j] if @board[i][j].downcase == "o"
        j += 1
      end
      i += 1
    end
    array_o
  end

  def computer_moves(arr)
    arr.select do |space|
      k = space[0]
      l = space[1]
      if @board[k][l].upcase == @board[k][l]
        @board[k - 1][l + 1] == " " ||
        @board[k - 1][l - 1] == " " ||
        @board[k + 1][l + 1] ||
        @board[k + 1][l - 1]
      else
        @board[k - 1][l + 1] == " " ||
        @board[k - 1][l - 1] == " "
      end
    end
  end

  def computer_jumps(arr)
    arr.select do |space|
      k = space[0]
      l = space[1]
      if @board[k + 1] &&
         @board[k + 2] &&
         @board[k][l].upcase == @board[k][l]
        ((@board[k - 1][l + 1] == "x" || @board[k - 1][l + 1] == "X") &&
         @board[k - 2][l + 2] == " ") ||
          ((@board[k - 1][l - 1] == "x" || @board[k - 1][l - 1] == "X") &&
           @board[k - 2][l - 2] == " ") ||
          ((@board[k + 1][l + 1] == "x" || @board[k + 1][l + 1] == "X") &&
           @board[k + 2][l + 2] == " ") ||
          ((@board[k + 1][l - 1] == "x" || @board[k + 1][l - 1] == "X") &&
           @board[k + 2][l - 2] == " ")
      else
        ((@board[k - 1][l + 1] == "x" || @board[k - 1][l + 1] == "X") &&
         @board[k - 2][l + 2] == " ") ||
          ((@board[k - 1][l - 1] == "x" || @board[k - 1][l - 1] == "X") &&
           @board[k - 2][l - 2] == " ")
      end
    end
  end

  def computer_turn
    jumps_array = computer_jumps(computer_checkers)
    moves_array = computer_moves(computer_checkers)

    if jumps_array.length > 0
      while true
        row = jumps_array[0][0]
        column = jumps_array[0][1]

        if @board[row][column] == @board[row][column].upcase &&
           @board[row + 2][column - 2] == " " &&
           (@board[row + 1][column - 1] == "x" ||
            @board[row + 1][column - 1] == "X")
          jump(row, column, (row + 2), (column - 2))
          jumper = [row + 2, column - 2]
        elsif @board[row][column] == @board[row][column].upcase &&
              @board[row + 2][column + 2] == " " &&
              (@board[row + 1][column + 1] == "x" ||
               @board[row + 1][column - 1] == "X")
          jump(row, column, (row + 2), (column + 2))
          jumper = [row + 2, column + 2]
        elsif @board[row - 2][column - 2] == " " &&
              (@board[row - 1][column - 1] == "x" ||
               @board[row - 1][column - 1] == "X")
          jump(row, column, (row - 2), (column - 2))
          jumper = [row - 2, column - 2]
        elsif @board[row - 2][column + 2] == " " &&
              (@board[row - 1][column + 1] == "x" ||
               @board[row - 1][column + 1] == "X")
          jump(row, column, (row - 2), (column + 2))
          jumper = [row - 2, column + 2]
        end

        jumps_array = computer_jumps(computer_checkers)
        if jumps_array[0] != jumper
          return @board
        end
      end
    else
      row = moves_array[0][0]
      column = moves_array[0][1]
      if @board[row + 1]
        if @board[row][column] == @board[row][column].upcase &&
           @board[row + 1][column + 1] == " "
          move(row, column, (row + 1), (column + 1))
        elsif @board[row][column] == @board[row][column].upcase &&
              @board[row + 1][column - 1] == " "
          move(row, column, (row + 1), (column - 1))
        elsif @board[row - 1][column + 1] == " "
          move(row, column, (row - 1), (column + 1))
        else
          move(row, column, (row - 1), (column - 1))
        end
      elsif @board[row - 1][column + 1] == " "
        move(row, column, (row - 1), (column + 1))
      else
        move(row, column, (row - 1), (column - 1))
      end
    end
  end
end
