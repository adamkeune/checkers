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

  def move(row1, column1, row2, column2)
    if @board[row1][column1].downcase == @current_player
      checker = @board[row1][column1]

      if @board[row1][column1] == @board[row1][column1].upcase
        if @board[row2][column2] == " " &&
           (row1 - row2).abs == 1 &&
           (column1 - column2).abs == 1
          @board[row1][column1] = " "
          @board[row2][column2] = checker
          toggle_player(current_player)
          @board
        else
          "Invalid move"
        end
      elsif @board[row1][column1] == "x"
        if @board[row2][column2] == " " &&
           row2 - row1 == 1 &&
           (column1 - column2).abs == 1
          @board[row1][column1] = " "
          @board[row2][column2] = checker
          toggle_player(current_player)
          @board
        else
          "Invalid move"
        end
      elsif @board[row1][column1] == "o"
        if @board[row2][column2] == " " &&
           row1 - row2 == 1 &&
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
    if (row1 - row2).abs == 2 &&
       (column1 - column2).abs == 2 &&
       @board[jumped_row][jumped_column] != " " &&
       @board[jumped_row][jumped_column] != current_player
      @board[row1][column1] = " "
      @board[jumped_row][jumped_column] = " "
      @board[row2][column2] = checker
      toggle_player(current_player)
      @board
    else
      "Invalid jump"
    end
  end

  def multiple_jump
  end
end
