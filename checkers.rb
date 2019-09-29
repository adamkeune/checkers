class Checkers
  attr_accessor :board

  def initialize
    @board = [
      [" ", "x", " ", "x", " ", "x", " ", "x"],
      ["x", " ", "x", " ", "x", " ", "x", " "],
      [" ", "x", " ", "x", " ", "x", " ", "x"],
      [" ", " ", " ", " ", " ", " ", " ", " "],
      [" ", " ", " ", " ", " ", " ", " ", " "],
      ["o", " ", "o", " ", "o", " ", "o", " "],
      [" ", "o", " ", "o", " ", "o", " ", "o"],
      ["o", " ", "o", " ", "o", " ", "o", " "],
    ]
  end

  def board
    @board
  end

  def find_piece(symbol, number)
    symbol_array = []
    @board.each do |row|
      row.each do |i|
        symbol_array << i if i == symbol
      end
    end
    symbol_array.fetch(number - 1)
  end

  def move
    # find all remaining x's and o's and place in arrays
    # find specified piece
    # move piece specified direction
    # return new game board
  end
end
